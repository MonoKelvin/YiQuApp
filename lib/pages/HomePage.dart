import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/pages/AddIdlePage.dart';
import 'package:yiqu/widgets/CategoriesScrollBarWidget.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';
import 'package:yiqu/widgets/IdleCardWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yiqu/widgets/TextInputWidget.dart';
import 'package:yiqu/widgets/RoundedButtonWidget.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController;
  // String _orderValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);
  }

  void _onRefresh() {
    /*.  after the data return,
        use _refreshController.refreshComplete() or refreshFailed() to end refreshing
   */
  }

  void _onLoading() {
    /*
        use _refreshController.loadComplete() or loadNoData() to end loading
   */
  }

  // don't forget to dispose refreshController
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获得设备像素比列
    // MediaQueryData queryData;
    // queryData = MediaQuery.of(context);
    // print(queryData.devicePixelRatio);

    return Scaffold(
      backgroundColor: AppTheme.widgetBackground,

      // 中间的添加物品的按钮
      floatingActionButton: RoundedButtonWidget(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddIdlePage()));
        },
        child: Icon(Icons.add, color: AppTheme.mainBackground),
      ),

      // 中间的添加物品的按钮
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      // 主要内容
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 顶部搜索栏和分类的滚动条
              Container(
                height: 106.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(left: 8.0, top: 8.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          PopupMenuButton(
                            icon: Icon(Icons.sort),
                            offset: Offset(14, 36),
                            // TODO: 实现它
                            onSelected: (String value) {},
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuItem<String>>[
                                  PopupMenuItem<String>(
                                    value: "ascending",
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.arrow_upward, size: 25.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "价格升序",
                                          style: AppTheme.titleTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "onlyToday",
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.today),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "只看今天",
                                          style: AppTheme.titleTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "morePraise",
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.whatshot, size: 25.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "最多点赞",
                                          style: AppTheme.titleTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  _customPriceMenuItem(),
                                ],
                          ),
                          Expanded(
                            child: TextInputWidget(
                              hintText: "搜索你想要的闲置吧(๑*◡*๑)",
                              icon:
                                  Icon(Icons.search, color: AppTheme.inactive),
                              // TODO: 开启搜索
                              onCompleted: () {
                                //print("searching...");
                              },
                            ),
                          ),
                          SizedBox(width: 8.0),
                          _showNotification(),
                        ],
                      ),
                    ),
                    Expanded(child: CategoriesScrollBarWidget()),
                  ],
                ),
                decoration: BoxDecoration(
                  color: AppTheme.mainBackground,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 20.0,
                      color: AppTheme.blueCardShadow.withOpacity(0.5),
                    ),
                  ],
                ),
              ),

              //主要内容
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    // TODO: 商品来源服务器
                    itemCount: myIdles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IdleInfoCardWidget(idle: myIdles[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Badge _showNotification() {
    return Badge(
      padding: EdgeInsets.all(4.0),
      position: BadgePosition.bottomLeft(bottom: 12.0, left: 12.0),
      badgeColor: AppTheme.mainRed,
      badgeContent: Text('6',
          style: AppTheme.subTextStyle
              .copyWith(color: AppTheme.mainBackground, fontSize: 8.0)),
      child: Icon(Icons.notifications),
    );
  }

  PopupMenuItem<String> _customPriceMenuItem() {
    return PopupMenuItem(
      height: 72.0,
      value: "customPrice",
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(width: 8.0),
              Text(
                "自定义价格区间",
                style: AppTheme.titleTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text("￥", style: AppTheme.inactiveTextStyle.copyWith(
                  fontSize: 16.0
                )),
              ),
              Expanded(
                child: Container(
                  width: 50.0,
                  child: DigitalInputWidget(
                    hintText: "最低",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text("~", style: AppTheme.inactiveTextStyle.copyWith(
                  fontSize: 16.0
                )),
              ),
              Expanded(
                child: Container(
                  width: 50.0,
                  child: DigitalInputWidget(
                    hintText: "最高",
                  ),
                ),
              ),
              IconButtonWidget(
                inactiveColor: AppTheme.widgetBackground,
                isActive: true,
                isJustClick: false,
                iconData: Icons.check_box,
                // TODO: 实现它
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),

    );
  }
}
