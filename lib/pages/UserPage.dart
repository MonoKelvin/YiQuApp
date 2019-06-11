import 'package:flutter/material.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/IdleCardWidget.dart';

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Idle> _idles = [];
    AppData.allIdles.forEach((_idle) {
      if (_idle.getUser == user) {
        _idles.add(_idle);
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "用户详情",
            style: AppTheme.titleTextStyle,
          ),
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      HeadIconWidget(
                          user: this.user, isRoutePage: false, radius: 60.0),
                      Text(
                        '@${user.getUserName}',
                        style: AppTheme.titleTextStyle.copyWith(
                          height: 1.5
                        ),
                      ),
                      Text(
                        '${user.signiture}',
                        style: AppTheme.subtitleTextStyle.copyWith(
                          color: AppTheme.inactive,
                          height: 1.2
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                user.gender == "男" ? "— 他的宝贝 —" : "— 她的宝贝 —",
                style: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _idles.length,
                    itemBuilder: (_, int index) {
                      return IdleInfoCardWidget(
                        idle: AppData.allIdles[index],
                        isNeedBottomWidgets: false,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
