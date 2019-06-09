import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

class IconButtonWidget extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final double size;
  final Color inactiveColor;
  final Color activeColor;
  final bool isActive;
  final bool isJustClick;

  const IconButtonWidget({
    Key key,
    this.size = 24.0,
    this.isActive = false,
    this.isJustClick = true,
    this.inactiveColor = AppTheme.inactive,
    this.activeColor = AppTheme.unselected,
    @required this.iconData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _IconButtonWidgetState createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  Color _iconColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _iconColor = (widget.isActive && !widget.isJustClick)
        ? widget.activeColor
        : widget.inactiveColor;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.iconData, color: _iconColor, size: widget.size),
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      onPressed: () {
        setState(() {
          if (widget.isJustClick) {
            _iconColor = widget.activeColor;
            Future.delayed(
                Duration(milliseconds: 100),
                () => setState(() {
                      _iconColor = widget.inactiveColor;
                      widget.onPressed();
                    }));
          } else {
            Future.delayed(
                Duration(milliseconds: 100),
                () => setState(() {
                      _iconColor = widget.isActive
                          ? widget.inactiveColor
                          : widget.activeColor;
                      widget.onPressed();
                    }));
            _iconColor = widget.inactiveColor;
          }
        });
      },
    );
  }
}
