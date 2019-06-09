import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

class RoundedButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Color shadowColor;
  final double width;
  final double height;
  final Widget child;
  final VoidCallback onPressed;

  const RoundedButtonWidget(
      {Key key,
      this.buttonColor = AppTheme.mainBlue,
      this.shadowColor = AppTheme.blueButtonShadow,
      this.width = 60.0,
      this.height = 60.0,
      @required this.child,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(max(width, height)),
        ),
        color: buttonColor,
        child: child,
        onPressed: onPressed,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(max(width, height)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 4.0),
            blurRadius: 10.0,
            color: shadowColor,
          ),
        ],
      ),
    );
  }
}
