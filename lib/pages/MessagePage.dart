import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/pages/PersonalCenterPage.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
import 'package:intl/intl.dart';

/// 聊天主页面 MessagePage 控件定义为一个有状态控件
class MessagePage extends StatefulWidget {
  final User friendUser;

  const MessagePage({Key key, this.friendUser}) : super(key: key);

  @override
  State createState() => MessagePageState();
}

/// MessagePageState 状态中实现聊天内容的动态更新
class MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];

  /// 聊天窗口的文本输入控件
  final TextEditingController _textController = TextEditingController();

  /// 到 MessagePageState 对象中定义一个标志位
  bool _isComposing = false;

  /// 定义发送文本事件的处理函数
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false; // 重置 _isComposing 值
    });

    DateTime time = DateTime.now();

    ChatMessage message = ChatMessage(
      myself,
      text: text,
      isMe: true,
      time: time.toString().substring(5, 19),
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  //定义文本输入框控件
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: AppTheme.mainDark),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                cursorRadius: Radius.circular(5.0),
                controller: _textController,
                onChanged: (String text) {
                  // 通过onChanged事件更新 _isComposing 标志位的值
                  setState(() {
                    // 必须有内容
                    _isComposing = text.length > 0;
                    // 不能全是空格
                    if (text.trim() == "") {
                      _isComposing = false;
                    }
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "发送一条消息吧(｡･ω･｡)",
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) // 遍历_messages数组
      message.animationController.dispose(); // 释放动效
    super.dispose();
  }

  //定义整个聊天窗口的页面元素布局
  Widget build(BuildContext context) {
    return Scaffold(
      //页面脚手架
      appBar: AppBar(title: Text(widget.friendUser.getUserName)),
      body: Column(children: <Widget>[
        Flexible(
          //子控件可柔性填充，如果下方弹出输入框，使消息记录列表可适当缩小高度
          child: ListView.builder(
            //可滚动显示的消息列表
            reverse: true, //反转排序，列表信息从下至上排列
            itemBuilder: (_, int index) => _messages[index], //插入聊天信息控件
            itemCount: _messages.length,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            color: AppTheme.mainBackground,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8.0),
              bottom: Radius.zero,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20.0,
                offset: Offset(0.0, -10.0),
                color: AppTheme.blueCardShadow,
              ),
            ],
          ),
          child: _buildTextComposer(), //页面下方的文本输入控件
        ),
      ]),
    );
  }
}

/// 单条聊天信息控件
class ChatMessage extends StatelessWidget {
  final User _user;
  final String text;
  final String time;
  final AnimationController animationController;
  final bool isMe;

  ChatMessage(this._user,
      {this.text,
      this.time,
      this.animationController,
      this.isMe = true}); //加入动画控制器对象

  @override
  Widget build(BuildContext context) {
    Widget msgWidget;
    if (isMe) {
      msgWidget = Container(
        padding:
            EdgeInsets.only(left: 32.0, right: 8.0, top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, bottom: 4.0, right: 8.0),
                    child: Text(time, style: AppTheme.subTextStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(text, style: AppTheme.messageTextStyle),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        color: AppTheme.mainBlue,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 4.0),
                            blurRadius: 8.0,
                            color: AppTheme.blueButtonShadow.withOpacity(0.5),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            ImageBlockWidget(
              image: _user.headImage.image,
              width: 46.0,
              height: 46.0,
              borderRadius: 46.0,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PersonalCenterPage()));
              },
            ),
          ],
        ),
      );
    } else {
      msgWidget = Container(
        padding:
            EdgeInsets.only(left: 8.0, right: 32.0, top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImageBlockWidget(
              image: _user.headImage.image,
              width: 46.0,
              height: 46.0,
              borderRadius: 46.0,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PersonalCenterPage()));
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 4.0, left: 8.0),
                    child: Text(time, style: AppTheme.subTextStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(text, style: AppTheme.friendMessageTextStyle),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        color: AppTheme.mainBackground,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 4.0),
                            blurRadius: 8.0,
                            color: AppTheme.blueButtonShadow.withOpacity(0.2),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return SizeTransition(
        // 用 SizeTransition 动效控件包裹整个控件，定义从小变大的动画效果
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOutQuint,
        ), // 指定曲线类型
        axisAlignment: 0.0, // 对齐
        child: msgWidget);
  }
}
