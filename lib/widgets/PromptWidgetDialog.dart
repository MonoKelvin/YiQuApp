import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

class PromptWidgetDialog extends Dialog {
  final String contents;
  final Widget child;

  PromptWidgetDialog({this.contents, this.child = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: new Center(
        child: new Container(
          decoration: new ShapeDecoration(
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.all(new Radius.circular(10)))),
          width: 160,
          height: 160,
          padding: EdgeInsets.all(10),
          child: new Column(
            children: <Widget>[
              child,
              Text(
                contents,
                style: AppTheme.subtitleTextStyle,
                // softWrap: false,
                textAlign: TextAlign.center,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }

  static showAndWaitSecondToClose(BuildContext context, { String contents,
      int ms = 1500, Widget child}) {
    showDialog(
        context: context,
        builder: (context) {
          return PromptWidgetDialog(
            contents: contents,
            child: child,
          );
        });
    Future.delayed(Duration(milliseconds: ms), () => Navigator.pop(context));
  }
}
