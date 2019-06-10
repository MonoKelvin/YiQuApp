import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/utilities/FileOperation.dart';
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
  int _groupValue = -1;
  String _currentLable;
  List<Widget> _imgBlockList = List<Widget>();
  Container _photoAdder;

  @override
  void initState() {
    super.initState();
    _preIdle.labels = List();
    _photoAdder = Container(
      width: 110.0,
      height: 110.0,
      // child:
      decoration: BoxDecoration(
        color: AppTheme.widgetBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      // constraints: BoxConstraints(minHeight: 110, minWidth: 110),
    );
    _imgBlockList.add(_photoAdder);
  }

  /*拍照*/
  // _takePhoto() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     _imgPath = image;
  //     if (_imgPath != null) {
  //       _imgBlockList.add(ImageBlockWidget(
  //         width: 110.0,
  //         height: 110.0,
  //         image: Image.file(_imgPath).image,
  //       ));
  //     } else {
  //       showToast(" 你取消了选择图片 ");
  //     }
  //   });
  // }

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
        _imgBlockList.add(ImageBlockWidget(
          width: 110.0,
          height: 110.0,
          image: Image.file(_imgPath).image,
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
                      return Stack(
                        alignment: _photoAdder != imgBlock
                            ? Alignment.topRight
                            : Alignment.center,
                        children: <Widget>[
                          imgBlock,
                          _photoAdder != imgBlock
                              ? Positioned(
                                  child: IconButtonWidget(
                                    iconData: Icons.delete,
                                    activeColor: AppTheme.mainBackground,
                                    inactiveColor: AppTheme.mainBackground,
                                    onPressed: () {
                                      setState(() {
                                        _imgBlockList.remove(imgBlock);
                                      });
                                    },
                                  ),
                                )
                              : Positioned(
                                  child: IconButtonWidget(
                                    onPressed: _openGallery,
                                    iconData: Icons.add_a_photo,
                                    size: 36.0,
                                    activeColor: AppTheme.activeWhenPressed,
                                  ),
                                ),
                        ],
                      );
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
              hintText: "给你的宝贝起个名字吧！(=^ェ^=)",
              maxLength: 32,
              onChanged: (String value) => _preIdle.title = value,
            ),

            // 描述
            Padding(
              child: Text("描述", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            TextInputWidget(
              hintText: "描述你的宝贝，让更多人感兴趣 ( • ̀ω•́ )✧",
              maxLength: 1000,
              borderRadius: 8.0,
              maxLines: 6,
              onChanged: (String value) => _preIdle.description = value,
            ),

            // 定价*
            Padding(
              child: Text("定价*", style: AppTheme.titleTextStyle),
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
                    hintText: "给你的宝贝定个价 (＾＿－)",
                    onChanged: (String value) =>
                        _preIdle.price = double.parse(value),
                  ),
                ),
              ],
            ),

            // 分类
            Padding(
              child: Text("分类*", style: AppTheme.titleTextStyle),
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            GridView.count(
              padding: EdgeInsets.all(6.0),
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 2.5,
              shrinkWrap: true,
              children: categories.map((value) {
                final bool tmp = _groupValue == categories.indexOf(value);
                return FlatButton(
                  color: tmp ? AppTheme.mainDark : AppTheme.widgetBackground,
                  onPressed: () {
                    setState(() {
                      _groupValue = categories.indexOf(value);
                      _preIdle.category = value;
                    });
                  },
                  child: Text(
                    value,
                    style: tmp
                        ? AppTheme.foregroundTextStyle
                        : AppTheme.subtitleTextStyle,
                  ),
                  shape: StadiumBorder(),
                );
              }).toList(),
            ),

            // 标签
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("标签*", style: AppTheme.titleTextStyle),
                IconButtonWidget(
                  iconData: Icons.add_box,
                  // TODO: 添加标签
                  onPressed: () {
                    if (_preIdle.labels != null &&
                        _preIdle.labels.length >= 10) {
                      showToast("你添加的标签太多啦！(｡･｀ω´･｡)");
                    } else {
                      showDialog(
                        builder: (BuildContext context) {
                          return _addLabelDialog();
                        },
                        context: context,
                      );
                    }
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
                padding: EdgeInsets.only(top: 100.0, bottom: 40.0),
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
                    // barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return _cancelPublishDialog();
                    });
              },
            ),

            // TODO: 保存发布信息
            RoundedButtonWidget(
              child: Icon(Icons.check, color: AppTheme.mainBackground),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return new LoadingDialog();
                    });

                // Navigator.pop(context);

                if (_imgBlockList.length > 1) {
                  // 跳过第一张添加图片的控件
                  _preIdle.images = new List<Image>(8);
                  int i = 0;
                  for (var img
                      in _imgBlockList.skip(1).cast<ImageBlockWidget>()) {
                    _preIdle.images[i] = Image(image: img.image);
                    i++;
                  }
                } else {
                  showToast(" 请添加几张照片好不好呀 (*︾▽︾) ");
                  return;
                }

                if (!isValidTextInput(_preIdle.title)) {
                  showToast(" 标题没有写哦 ┗( ▔, ▔ )┛ ");
                  return;
                }

                if (_preIdle.price == null || _preIdle.price.isNaN) {
                  showToast(" 你的宝贝不要钱的吗？ (～￣▽￣)～ ");
                  return;
                }

                if (_preIdle.category == null || _preIdle.category.isEmpty) {
                  showToast(" 分类忘了选吗？(ﾐ´ω`ﾐ) ");
                  return;
                }

                if (_preIdle.labels.isEmpty) {
                  showToast(" 加个标签吧，让更多人看到你 (❁´◡`❁) ");
                  return;
                }

                _preIdle.regenerateReleaseTime();
                myIdles.add(_preIdle);
              },
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
                  _currentLable.trim() == "") {
                return;
              }
              if (_preIdle.labels.contains(_currentLable)) {
                showToast("你已经添加过该标签了 (｡･ω･｡)");
                return;
              }

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

class LoadingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: new Center(
        child: new Container(
          decoration: new ShapeDecoration(
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.all(new Radius.circular(10)))),
          width: 160,
          height: 160,
          padding: EdgeInsets.all(10),
          child: new Column(
            children: <Widget>[
              Icon(Icons.check, size: 48.0, color: AppTheme.mainGreen),
              Text(
                "添加成功，快去首页看看你的宝贝吧！Y(^o^)Y ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                softWrap: false,
                textAlign: TextAlign.center,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }
}
