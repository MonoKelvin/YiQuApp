import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yiqu/data/Idle.dart';
// import 'package:http/http.dart' as http;
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/pages/IdleDetailsPage.dart';
import 'package:yiqu/pages/SendMessagePage.dart';
import 'package:yiqu/widgets/HeadIconWidget.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:yiqu/widgets/TosatWidget.dart';

class IdleInfoCardWidget extends StatefulWidget {
  final Idle idle;
  final isNeedBottomWidgets;

  const IdleInfoCardWidget(
      {Key key, @required this.idle, this.isNeedBottomWidgets = true})
      : super(key: key);

  @override
  _IdleInfoCardWidgetState createState() => _IdleInfoCardWidgetState();
}

class _IdleInfoCardWidgetState extends State<IdleInfoCardWidget> {
  int likeCount = 0;
  // String _idleType;
  bool _isThumbUp = false; // 是否点赞

  // String _titleText;

  @override
  void initState() {
    super.initState();

    // switch (widget.idle.idleType) {
    //   case EIdleType.Change:
    //     _idleType = "交换";
    //     break;
    //   case EIdleType.Sell:
    //     _idleType = "出售";
    //     break;
    //   default:
    //     _idleType = "免费";
    //     break;
    // }

    //限制标题的显示
    // if (commodity.title.length > 9) {
    //   _titleText = commodity.title.substring(0, 9) + "...";
    // } else {
    //   _titleText = commodity.title;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 主要信息内容，从左到右
          InkWell(
            // 当点击卡片时，应跳转到详情页
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      IdleDetailsPage(idle: widget.idle),
                ),
              );
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                // TODO: Use Image Form Server.
                // 图片内容，默认图片选第一张
                ImageBlockWidget(
                  image: widget.idle.images[0].image,
                  width: 110,
                  height: 110.0,
                ),

                // 必须先使用 Expanded 把剩余部分撑开。
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //标题和价格的展示
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${widget.idle.title}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.titleTextStyle,
                                  ),
                                  Text(
                                    "￥${widget.idle.price}",
                                    style: AppTheme.largeTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),

                            //标题和头像的间距
                            SizedBox(width: 8.0),

                            Column(
                              children: <Widget>[
                                //头像展示
                                HeadIconWidget(user: widget.idle.getUser),
                                SizedBox(height: 4.0),
                                SizedBox(
                                  width: 80.0,
                                  child: Text(
                                    "@${widget.idle.getUser.getUserName}",
                                    style: AppTheme.inactiveTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        // SizedBox(height: 4.0),

                        Container(
                          padding: EdgeInsets.only(top: 4.0),
                          height: 36.0,
                          child: Text(
                            widget.idle.description,
                            style: AppTheme.subtitleTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Text(
                          "发布时间：${widget.idle.getMonthAndDay()}",
                          style: AppTheme.inactiveTextStyle,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 分开上面的物品信息和下方的控件，不是为了显示
          SizedBox(height: 8.0),

          // 分隔条，显示为一条线
          Divider(
              height: 0.0,
              color: widget.isNeedBottomWidgets
                  ? AppTheme.widgetBackground
                  : Colors.transparent),

          // 底部小控件
          widget.isNeedBottomWidgets
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // Icons
                  children: <Widget>[
                    //发送消息
                    IconButtonWidget(
                      iconData: Icons.send,
                      onPressed: () {
                        //TODO: 跳转到发送消息的界面
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SendMessagePage(
                                friendUser: widget.idle.getUser),
                          ),
                        );
                      },
                    ),

                    // 喜欢（点赞）
                    Row(
                      children: <Widget>[
                        IconButtonWidget(
                          iconData: Icons.thumb_up,
                          activeColor: AppTheme.mainBlue,
                          isActive: _isThumbUp,
                          isJustClick: false,
                          onPressed: () {
                            showToast(_isThumbUp
                                ? "  已取消点赞 o(´^｀)o  "
                                : "  点赞成功 (*^▽^*)  ");
                            setState(() {
                              if (_isThumbUp) {
                                widget.idle.satisfiedCount -= 1;
                              } else {
                                widget.idle.satisfiedCount += 1;
                              }
                              _isThumbUp = !_isThumbUp;
                            });
                          },
                        ),
                        Text(
                          "${widget.idle.satisfiedCount}",
                          style: AppTheme.inactiveTextStyle
                              .copyWith(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(height: 4.0),
        ],
      ),

      // 背景装饰
      decoration: BoxDecoration(
        color: AppTheme.mainBackground,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: AppTheme.blueCardShadow.withOpacity(0.4),
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
    );
  }
}
