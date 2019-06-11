import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/pages/SendMessagePage.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('消息列表'),
          elevation: 0.0,
        ),
        body: ListView.builder(
          itemCount: AppData.messagesList.length,
          itemBuilder: (BuildContext context, int index) {
            List<User> _users = [];
            AppData.messagesList.forEach((_user, _msgs) {
              _users.add(_user);
              if (_msgs == null) _msgs = [];
            });

            return GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.delete_forever, size: 22.0),
                            SizedBox(width: 4.0),
                            Text("清空聊天记录", style: AppTheme.titleTextStyle),
                          ],
                        ),
                        content: Text("清空之后你们之间\n就没有小秘密了呀！￣ω￣=",
                            textAlign: TextAlign.center,
                            style: AppTheme.alertTextStyle),
                        backgroundColor: AppTheme.mainBackground,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 0.0,
                        actions: <Widget>[
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8.0),
                              child: Text("清空吧，感觉不会再爱了",
                                  style: AppTheme.titleTextStyle
                                      .copyWith(fontSize: 12.0)),
                            ),
                            onTap: () {
                              setState(() {
                                AppData.messagesList[_users[index]].clear();
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8.0),
                              child: Text("手抖了",
                                  style: AppTheme.titleTextStyle
                                      .copyWith(fontSize: 12.0)),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppTheme.mainBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 2.0),
                      blurRadius: 12.0,
                      color: AppTheme.blueCardShadow.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        HeadIconWidget(
                          user: _users[index],
                          isRoutePage: false,
                          // user: userMessages,
                        ),
                        SizedBox(width: 8.0),
                        Text(_users[index].getUserName,
                            style: AppTheme.titleTextStyle),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "你们有${AppData.messagesList[_users[index]].length}条消息来往",
                          style: AppTheme.subtitleTextStyle
                              .copyWith(color: AppTheme.inactive),
                        ),
                        IconButtonWidget(
                          iconData: Icons.send,
                          onPressed: () {
                            //TODO: 跳转到发送消息的界面
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SendMessagePage(friendUser: _users[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
