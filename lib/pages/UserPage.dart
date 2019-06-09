import 'package:flutter/material.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/data/AppConfig.dart';

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user.getUserName}',
          style: AppTheme.titleTextStyle,
        ),
        elevation: 0.0,
      ),
    );
  }
}
