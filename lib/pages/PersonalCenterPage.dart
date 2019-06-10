import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/widgets/DashLineWidget.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/MenuItemWidget.dart';

class PersonalCenterPage extends StatefulWidget {
  @override
  _PersonalCenterPageState createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  @override
  Widget build(BuildContext context) {
    final BoxDecoration dec = BoxDecoration(
      color: AppTheme.mainBackground,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: AppTheme.blueCardShadow.withOpacity(0.4),
          offset: Offset(0.0, 4.0),
          blurRadius: 10.0,
          spreadRadius: 0.0,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            // 头像和信息容器
            Container(
              margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
              padding: EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Column(
                children: <Widget>[
                  HeadIconWidget(
                    user: myself,
                    radius: 60.0,
                    isRoutePage: false,
                  ),
                  Text(
                    "@${myself.getUserName}",
                    style: AppTheme.titleTextStyle.copyWith(height: 2.0),
                  ),
                  Text(myself.signiture,
                      style: AppTheme.subtitleTextStyle.copyWith(
                        color: AppTheme.activeWhenPressed,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DashLineWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("交易/件",
                              style: AppTheme.subtitleTextStyle.copyWith(
                                color: AppTheme.activeWhenPressed,
                              )),
                          Text("3", style: AppTheme.bigestTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("余额/元",
                              style: AppTheme.subtitleTextStyle.copyWith(
                                color: AppTheme.activeWhenPressed,
                              )),
                          Text("233.66", style: AppTheme.bigestTextStyle),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("收入/元",
                              style: AppTheme.subtitleTextStyle.copyWith(
                                color: AppTheme.activeWhenPressed,
                              )),
                          Text("67", style: AppTheme.bigestTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: dec,
            ),

            Container(
              decoration: dec,
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: <Widget>[
                  Text("— 更多功能 —",
                      style: AppTheme.subtitleTextStyle
                          .copyWith(color: AppTheme.activeWhenPressed, height: 2.0)),
                  SizedBox(height: 8.0),
                  // TODO: 完成每个功能的界面
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Image(
                              image:
                                  AssetImage("assets/images/icon_takerice.png"),
                              width: 46.0,
                            ),
                            Text("帮我带饭", style: AppTheme.titleTextStyle.copyWith(
                              fontSize: 14.0,
                              height: 1.6
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                  "assets/images/icon_takecourier.png"),
                              width: 48.0,
                            ),
                            Text("代取快递", style: AppTheme.titleTextStyle.copyWith(
                              fontSize: 14.0,
                              height: 1.5
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                  "assets/images/icon_developing.png"),
                              width: 50.0,
                            ),
                            Text("拼命开发中...", style: AppTheme.titleTextStyle.copyWith(
                              fontSize: 14.0,
                              height: 1.5
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 菜单
            Container(
              decoration: dec,
              child: Column(
                children: <Widget>[
                  MenuItemWidget(menuIconData: Icons.person, menuLabel: "个人信息"),
                  MenuItemWidget(menuIconData: Icons.group, menuLabel: "我的好友"),
                  MenuItemWidget(
                      menuIconData: Icons.favorite, menuLabel: "我的收藏"),
                  MenuItemWidget(
                      menuIconData: Icons.shopping_basket, menuLabel: "闲置管理"),
                  MenuItemWidget(menuIconData: Icons.settings, menuLabel: "设置"),
                  MenuItemWidget(
                      menuIconData: Icons.perm_phone_msg, menuLabel: "问题反馈"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
