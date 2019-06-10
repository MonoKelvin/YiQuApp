import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:yiqu/data/AppConfig.dart';

enum EInputFormat {
  Text,
  Passward,
  Number,
  Float,
}

class TextInputWidget extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final String errorText;
  final int maxLength;
  final int maxLines;
  final EInputFormat format;
  final double borderRadius;
  final VoidCallback onCompleted;
  final Function(String value) onChanged;

  /// #### 验证内容的回调函数
  /// 参数：`value` 表示输入框中的内容
  ///
  /// 验证无误则返回`true`，验证失败则返回`false`
  final bool Function(String value) validator;

  TextInputWidget({
    Key key,
    this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.errorText,
    this.format = EInputFormat.Text,
    this.validator,
    this.icon,
    this.onCompleted,
    this.borderRadius = 100.0,
    this.onChanged,
    // this.isDigital = false,
  }) : super(key: key);

  // set setText(String value) => _text = value;
  // String get getText => _text;

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  bool _isInputError = false;

  Widget _icon() {
    if (widget.icon == null) {
      return SizedBox();
    } else {
      return Positioned(
        child: widget.icon,
        left: 10.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      TextField(
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        cursorRadius: Radius.circular(10.0),
        obscureText: widget.format == EInputFormat.Passward,
        keyboardType: (widget.format == EInputFormat.Float ||
                widget.format == EInputFormat.Number)
            ? TextInputType.number
            : TextInputType.text,
        inputFormatters: (widget.format != EInputFormat.Text &&
                widget.format != EInputFormat.Passward)
            ? <TextInputFormatter>[
                widget.format == EInputFormat.Number
                    ? WhitelistingTextInputFormatter.digitsOnly
                    : WhitelistingTextInputFormatter(
                        RegExp(r'^([0-9]+)|\.(\d{1,2})?$')),
              ]
            : null,
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: _isInputError
              ? AppTheme.alertBackground
              : AppTheme.widgetBackground,
          hintStyle: TextStyle(
              color: _isInputError
                  ? AppTheme.mainRed.withOpacity(0.2)
                  : AppTheme.inactive,
              fontSize: 14.0),
          contentPadding: EdgeInsets.only(
              left: widget.icon == null ? 16.0 : 36.0,
              right: 12.0,
              top: 12.0,
              bottom: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        onEditingComplete: widget.onCompleted,
        onChanged: widget.onChanged,
      ),
      _icon(),
    ]);
  }
}
