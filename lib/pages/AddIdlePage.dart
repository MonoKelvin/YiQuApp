import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
import 'package:yiqu/widgets/RoundedButtonWidget.dart';
import 'package:yiqu/widgets/TextInputWidget.dart';
import 'package:yiqu/widgets/TosatWidget.dart';
// import 'package:yiqu/widgets/TosatWidget.dart';

class AddIdlePage extends StatefulWidget {
  @override
  _AddIdlePageState createState() => _AddIdlePageState();
}

class _AddIdlePageState extends State<AddIdlePage> {
  Idle _preIdle = new Idle(kimono);
  var _imgPath;
  String _currentLable;
  List<Widget> _imgBlockList = List<Widget>();

  @override
  void initState() {
    super.initState();
    _preIdle.labels = List();
    _imgBlockList.add(Container(
      width: 110.0,
      height: 110.0,
      child: FlatButton(
        color: AppTheme.widgetBackground,
        onPressed: _openGallery,
        child: Icon(Icons.add_a_photo, size: 36.0, color: AppTheme.inactive),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ));
  }

  VoidCallback onCancel;

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
      if (_imgPath != null) {
        _imgBlockList.add(Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            ImageBlockWidget(
              width: 110.0,
              height: 110.0,
              image: Image.file(_imgPath).image,
            ),
            Positioned(
              child: IconButtonWidget(
                iconData: Icons.cancel,
                activeColor: AppTheme.mainGreen,
                inactiveColor: AppTheme.mainGreen,
                onPressed: onCancel,
              ),
            ),
          ],
        ));
      } else {
        showToast(" 你取消了选择图片 ");
      }
    });
  }

  /*相册*/
  _openGallery() async {
    if (_imgBlockList.length > 8) {
      showToast("  你添加的图片够多的啦 ヽ(#`Д´)ﾉ  ");
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
      if (_imgPath != null) {
        _imgBlockList.add(Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            ImageBlockWidget(
              width: 110.0,
              height: 110.0,
              image: Image.file(_imgPath).image,
            ),
            Positioned(
              child: IconButtonWidget(
                iconData: Icons.delete,
                activeColor: AppTheme.mainRed,
                inactiveColor: AppTheme.mainBackground,
                onPressed: onCancel,
              ),
            ),
          ],
        ));
      } else {
        showToast(" 你取消了选择图片 ");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布闲置', style: AppTheme.largeTitleTextStyle),
        // elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 添加照片
            Padding(
              child: Text("添加照片*", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Builder(
              builder: (_) {
                if (_preIdle.labels == null) {
                  return Container(width: 110.0, height: 110.0);
                }

                return Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: _imgBlockList.map((imgBlock) {
                    return Builder(builder: (BuildContext context) {
                      //var pos = _imgBlockList.indexOf(imgBlock) + 1;
                      onCancel = () {
                        setState(() {
                          _imgBlockList.remove(imgBlock);
                        });
                      };
                      return imgBlock;
                    });
                  }).toList(),
                );
              },
            ),
            //getBody(),

            // 标题
            Padding(
              child: Text("标题*", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            TextInputWidget(
              hintText: "不超过32个字（包括标点符号）",
              maxLength: 32,
            ),

            // 描述
            Padding(
              child: Text("描述", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            TextInputWidget(
              hintText: "描述你的宝贝，让更多人看到 ( • ̀ω•́ )✧",
              maxLength: 1000,
              borderRadius: 8.0,
              maxLines: 6,
            ),

            // 定价*
            Padding(
              child: Text("定价", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text("￥",
                      style:
                          AppTheme.inactiveTextStyle.copyWith(fontSize: 16.0)),
                ),
                Expanded(
                  child: TextInputWidget(
                    borderRadius: 50.0,
                    format: EInputFormat.Float,
                    hintText: "出售金额",
                  ),
                ),
              ],
            ),

            // 标签
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("标签", style: AppTheme.titleTextStyle),
                IconButtonWidget(
                  iconData: Icons.add_box,
                  // TODO: 添加标签
                  onPressed: () {
                    showDialog(
                      builder: (BuildContext context) {
                        return _addLabelDialog();
                      },
                      context: context,
                    );
                  },
                ),
              ],
            ),

            // 标签 Chip
            Builder(
              builder: (_) {
                if (_preIdle.labels == null) {
                  return SizedBox(height: 16.0);
                }
                return Wrap(
                  spacing: 4.0,
                  children: _preIdle.labels.map((chip) {
                    return Builder(builder: (BuildContext context) {
                      return Chip(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        label: Text(chip, style: AppTheme.subTextStyle),
                        backgroundColor: AppTheme.widgetBackground,
                        deleteIcon: Icon(Icons.close,
                            size: 18.0, color: AppTheme.inactive),
                        onDeleted: () {
                          setState(() {
                            _preIdle.labels.remove(chip);
                          });
                        },
                      );
                    });
                  }).toList(),
                );
              },
            ),

            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 100.0, bottom: 60.0),
                child: Text(
                  "— 我是有底线的 (*•ω•) —",
                  style: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0),
                ),
              ),
            ),

            // Positioned(
            //   child: null,
            // ),
          ],
        ),
      ),

      // 两个悬浮按钮
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RoundedButtonWidget(
              child: Icon(Icons.close, color: AppTheme.mainBackground),
              buttonColor: AppTheme.mainRed,
              shadowColor: AppTheme.redShadow,
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return _cancelPublishDialog();
                    });
              },
            ),

            // TODO: 保存发布信息
            RoundedButtonWidget(
              child: Icon(Icons.check, color: AppTheme.mainBackground),
              onPressed: () {},
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AlertDialog _addLabelDialog() {
    return AlertDialog(
      elevation: 0.0,
      title: Row(
        children: <Widget>[
          Icon(Icons.edit, size: 22.0),
          SizedBox(width: 4.0),
          Text("添加标签", style: AppTheme.titleTextStyle),
        ],
      ),
      content: TextInputWidget(
        hintText: "标签名",
        maxLength: 8,
        onChanged: (String value) {
          setState(() {
            _currentLable = value;
          });
        },
      ),
      backgroundColor: AppTheme.mainBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        IconButtonWidget(
          iconData: Icons.close,
          padding: EdgeInsets.only(top: 0, right: 16.0, bottom: 10.0),
          onPressed: () {
            _currentLable = "";
            Navigator.of(context).pop();
          },
        ),
        IconButtonWidget(
          iconData: Icons.check,
          padding: EdgeInsets.only(top: 0, right: 16.0, bottom: 10.0),
          onPressed: () {
            setState(() {
              if (_preIdle.labels == null ||
                  _currentLable == null ||
                  _currentLable.trim() == "" ||
                  _preIdle.labels.contains(_currentLable)) return;

              _preIdle.labels.add(_currentLable);
              _currentLable = "";
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  AlertDialog _cancelPublishDialog() {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.delete_forever, size: 22.0),
          SizedBox(width: 4.0),
          Text("放弃发布", style: AppTheme.titleTextStyle),
        ],
      ),
      content: Text(
        "放弃编辑之后就不可恢复了\n客官请三思啊！(=｀ω´=)",
        textAlign: TextAlign.center,
        style: AppTheme.alertTextStyle,
      ),
      backgroundColor: AppTheme.mainBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0.0,
      actions: <Widget>[
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Text("少废话, 给我关了",
                style: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0)),
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Text("手抖了",
                style: AppTheme.inactiveTextStyle.copyWith(fontSize: 12.0)),
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
