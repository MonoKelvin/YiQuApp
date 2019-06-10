import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

///
///分类的滚动条
///
class CategoriesScrollBarWidget extends StatefulWidget {
  @override
  _CategoriesScrollBarWidgetState createState() =>
      _CategoriesScrollBarWidgetState();
}

class _CategoriesScrollBarWidgetState extends State<CategoriesScrollBarWidget> {
  int isActive = 0;
  List _categories = categories;

  @override
  void initState() {
    super.initState();
    _categories.insert(0, "全部");
  }

  /// 选择分类，自动将未选中的设置为暗色
  seleteCategory(int index) {
    if (index < categories.length) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      color: AppTheme.mainBackground,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              // Icon(Icons.local_mall),
              FlatButton(
                child: Text(
                  _categories[index],
                  style: AppTheme.titleTextStyle,
                ),
                disabledTextColor: AppTheme.activeWhenPressed,
                splashColor: AppTheme.mainBackground,
                highlightColor: AppTheme.mainBackground,

                // TODO: 实现分类效果
                onPressed: () {
                  return null;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

///
///每一个类别的页面内显示内容
///
class CategoriesContextPageWidget extends StatefulWidget {
  @override
  _CategoriesContextPageWidgetState createState() =>
      _CategoriesContextPageWidgetState();
}

class _CategoriesContextPageWidgetState
    extends State<CategoriesContextPageWidget> {
  /// 当前页面
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        //该值可以控制页面滚动到任意位置，不会超过一半就滚过去或未超过一半滚回来
        pageSnapping: true,

        //倒置，123顺序变321
        // reverse: true,

        //默认水平滚动，这里设置为垂直滚动
        // scrollDirection: Axis.vertical,

        //页面改变事件
        onPageChanged: (currentPage) => debugPrint("page:$currentPage"),

        controller: PageController(
          // 一开始显示的页面
          initialPage: 0,

          //不保存用户滚动到的页面
          keepPage: false,

          //页面占用的视口
          viewportFraction: 0.8,
        ),

        children: <Widget>[
          Container(
            color: Colors.brown[900],
            alignment: Alignment.center,
            child: Text(
              "ONE",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.grey[900],
            alignment: Alignment.center,
            child: Text(
              "TWO",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[900],
            alignment: Alignment.center,
            child: Text(
              "THREE",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
