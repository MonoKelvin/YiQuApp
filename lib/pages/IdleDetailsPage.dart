import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
import 'package:yiqu/widgets/TosatWidget.dart';

/// 商品详情页面
class IdleDetailsPage extends StatefulWidget {
  final Idle idle;
  const IdleDetailsPage({Key key, this.idle}) : super(key: key);

  @override
  _IdleDetailsPageState createState() => _IdleDetailsPageState();
}

class _IdleDetailsPageState extends State<IdleDetailsPage> {
  bool _isInMyCollection = false; // 是否收藏

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isInMyCollection = false; //kimono.myCollection.contains(widget.commodity);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '闲置详情',
          style: AppTheme.largeTitleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeadIconWidget(
              user: widget.idle.getUser,
              radius: 50.0,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Text("@${widget.idle.getUser.getUserName}",
                  style: AppTheme.subTextStyle),
            ),

            // 轮播图片
            CarouselSlider(
              height: 360.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll:
                  widget.idle.images.length > 1 ? true : false,
              reverse: false,
              autoPlay: widget.idle.images.length > 1 ? true : false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeOutQuart,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              enlargeCenterPage: true,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
              items: widget.idle.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.all(18.0),
                      child: ImageBlockWidget(
                        width: 360.0,
                        image: i.image,
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0,
                          color: AppTheme.blueCardShadow,
                        ),
                      ]),
                    );
                  },
                );
              }).toList(),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.idle.title,
                style: AppTheme.titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Text("¥${widget.idle.price}", style: AppTheme.bigestTextStyle),

            // Container(
            //   margin: EdgeInsets.only(top: 4.0),
            //   width: 160.0,
            //   height: 4.0,
            //   decoration: BoxDecoration(
            //     color: AppTheme.mainDark,
            //     borderRadius: BorderRadius.circular(10.0),
            //     boxShadow: [
            //       BoxShadow(
            //         blurRadius: 2.0,
            //         offset: Offset(0.0, 1.0),
            //         color: AppTheme.mainDark.withBlue(80).withOpacity(0.8),
            //       ),
            //     ]
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "标签",
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 14.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 4.0, bottom: 10.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: widget.idle.labels.map((chip) {
                        return Builder(builder: (BuildContext context) {
                          return Chip(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            label: Text(chip, style: AppTheme.subTextStyle),
                            backgroundColor: AppTheme.widgetBackground,
                          );
                        });
                      }).toList(),
                    ),
                  ),
                  Text(
                    "发布时间",
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 14.0),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 4.0, bottom: 10.0),
                    child: Text(widget.idle.getMonthAndDay(),
                        style: AppTheme.subtitleTextStyle),
                  ),
                  Text(
                    "描述",
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 14.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 4.0, bottom: 10.0),
                    child: Text(widget.idle.description,
                        style: AppTheme.subtitleTextStyle),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButtonWidget(
                      iconData: Icons.share,
                      // TODO: 实现它
                      onPressed: () {},
                    ),
                    Text(
                      "分享",
                      style: AppTheme.inactiveTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButtonWidget(
                      iconData: Icons.photo_library,
                      // TODO: 实现它
                      onPressed: () {},
                    ),
                    Text(
                      "保存照片",
                      style: AppTheme.inactiveTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButtonWidget(
                      iconData: Icons.favorite,
                      activeColor: AppTheme.mainBlue,
                      isActive: _isInMyCollection,
                      isJustClick: false,
                      onPressed: () {
                        showToast(_isInMyCollection
                            ? "  已取消收藏 (▼ヘ▼#)  "
                            : "  收藏成功 (︶.̮︶✽)  ");
                        setState(() {
                          _isInMyCollection = !_isInMyCollection;
                        });
                      },
                    ),
                    Text(
                      "收藏",
                      style: AppTheme.inactiveTextStyle,
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 60.0, bottom: 40.0),
              child: Text(
                "— 我是有底线的 (*•ω•) —",
                style: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
