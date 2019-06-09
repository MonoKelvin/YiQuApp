import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yiqu/data/AppConfig.dart';

void showToast(String content) {
  Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppTheme.mainDark.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 12.0);
}
