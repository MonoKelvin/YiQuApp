import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:yiqu/data/AppConfig.dart';

class LineTextInputWidget extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final String errorText;
  final int maxLength;
  final bool isPassword;
  final VoidCallback onCompleted;
  final double borderRadius;
  // final bool isDigital;

  /// #### 验证内容的回调函数
  /// 参数：`value` 表示输入框中的内容
  ///
  /// 验证无误则返回`true`，验证失败则返回`false`
  final bool Function(String value) validator;

  LineTextInputWidget({
    Key key,
    this.hintText,
    this.maxLength,
    this.errorText,
    this.isPassword = false,
    this.validator,
    this.icon,
    this.onCompleted,
    this.borderRadius = 100.0,
    // this.isDigital = false,
  }) : super(key: key);

  // set setText(String value) => _text = value;
  // String get getText => _text;

  @override
  _LineTextInputWidgetState createState() => _LineTextInputWidgetState();
}

class _LineTextInputWidgetState extends State<LineTextInputWidget> {
  bool _isInputError = false;

  String validator(String value) {
    if (widget.validator == null) {
      _isInputError = false;
      return null;
    }

    if (widget.validator(value) == false) {
      setState(() {
        _isInputError = true;
      });
      return widget.errorText;
    }

    setState(() {
      _isInputError = false;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      TextFormField(
        maxLength: widget.maxLength,
        maxLines: 1,
        cursorRadius: Radius.circular(10.0),
        obscureText: widget.isPassword,
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
          contentPadding:
              EdgeInsets.only(left: 36.0, right: 16.0, top: 12.0, bottom: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),

        // onSaved: (value) {
        //   print(value);
        // },
        onEditingComplete: widget.onCompleted,
        validator: validator,
        // autovalidate: true, //不需点击提交也会实时验证
      ),
      Positioned(
        child: widget.icon,
        left: 10.0,
      ),
    ]);
  }
}

class DigitalInputWidget extends StatelessWidget {
  final String hintText;
  final int maxLength;
  final VoidCallback onCompleted;
  final double borderRadius;

  const DigitalInputWidget({
    Key key,
    this.hintText,
    this.maxLength,
    this.onCompleted,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: 1,
      cursorRadius: Radius.circular(10.0),
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppTheme.widgetBackground,
        hintStyle: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0),
        contentPadding: EdgeInsets.all(8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      onEditingComplete: onCompleted,
    );
  }
}
