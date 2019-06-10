import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/pages/AddIdlePage.dart';
// import 'package:yiqu/data/AppIconFont.dart';
import 'package:yiqu/pages/HomePage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yiqu/pages/LoginPage.dart';
import 'package:yiqu/pages/NoticesPage.dart';
import 'package:yiqu/pages/PersonalCenterPage.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      //IdleDetailsPage(idle: myIdles[0]), //MessagePage(friendUser: kimono),
      // localizationsDelegates: [
      //   //此处
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   //此处
      //   const Locale('zh', 'CH'),
      //   const Locale('en', 'US'),
      // ],
      theme: Theme.of(context).copyWith(
        // buttonColor: AppTheme.mainDark,
        // cardColor: AppTheme.mainBackground,
        // dialogBackgroundColor: AppTheme.mainBackground,
        // dividerColor: AppTheme.widgetBackground,
        // primaryIconTheme: AppTheme.iconActiveStyle,
        // selectedRowColor: AppTheme.widgetBackground,
        // toggleableActiveColor: AppTheme.mainDark,
        // unselectedWidgetColor: AppTheme.widgetBackground,
        // textSelectionColor: AppTheme.mainDark,
        disabledColor: AppTheme.widgetBackground,
        splashColor: AppTheme.mainBackground,

        hintColor: AppTheme.inactive,

        // accentColor: AppTheme.mainBlue,
        // accentTextTheme: TextTheme(
        //   body1: AppTheme.titleTextStyle,
        // ),
        // primaryTextTheme: TextTheme(
        //   body1: AppTheme.titleTextStyle,
        // ),

        scaffoldBackgroundColor: AppTheme.mainBackground,
        highlightColor: AppTheme.mainBackground,
        cursorColor: AppTheme.mainDark,
        appBarTheme: AppBarTheme.of(context).copyWith(
          color: AppTheme.mainBackground,
          elevation: 0.0,
          iconTheme: AppTheme.iconActiveStyle,
          textTheme: TextTheme(title: AppTheme.largeTitleTextStyle),
        ),

        iconTheme: IconThemeData(
          color: AppTheme.mainDark,
          size: 24.0
        )

        // bottomAppBarTheme: BottomAppBarTheme.of(context).copyWith(
        //   elevation: 20.0,
        //   color: AppTheme.mainBackground,
        //   shape: CircularNotchedRectangle(),
        // ),
      ),
    );
  }
}

class YiQuApp extends StatefulWidget {
  @override
  _YiQuAppState createState() => _YiQuAppState();
}

class _YiQuAppState extends State<YiQuApp> {
  int _currentTabIndex = 0;

  List<Widget> views;

  @override
  void initState() {
    super.initState();

    views = [
      HomePage(),
      // CommunityPage(),
      // MessagePage(),
      NoticesPage(),
      PersonalCenterPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(),
        footerBuilder: () => ClassicFooter(),
        clickLoadingWhenIdle: true,
        headerTriggerDistance: 100.0,
        hideFooterWhenNotFull: true,
        child: views[_currentTabIndex],
      ),

      // 底部导航栏
      bottomNavigationBar: Container(
        height: 54.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 20.0,
              color: AppTheme.blueCardShadow.withOpacity(0.5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0.0,

          // 当项目大于四个，项目会变成白色，设置type为fixed就不会了
          type: BottomNavigationBarType.fixed,

          // item 激活的颜色
          fixedColor: AppTheme.mainDark,

          // 未选中的 item 颜色
          unselectedItemColor: AppTheme.activeWhenPressed,

          // 当前选中的 item，从 0 开始
          currentIndex: _currentTabIndex,

          // 当点击某个 icon使
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
            });
          },

          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,

          // 内部 Icons 容器
          items: <BottomNavigationBarItem>[
            // 主页：所有物品
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // icon: Icon(AppIconFont.th_thumb_empty),
              // activeIcon: Icon(AppIconFont.th_thumb),
              title: Text("所有闲置"),

              // TODO: Select an Actived Icon
              // activeIcon: Icon(Icons.home),
            ),

            // 消息与聊天
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text("消息"),
            ),

            // 物品管理
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.shopping_basket),
            //   title: Text("物品管理"),
            // ),

            // 个人中心
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("个人中心"),
            ),
          ],
        ),
      ),
      //BottomNavigationBarWidget(),
    );
  }
}
