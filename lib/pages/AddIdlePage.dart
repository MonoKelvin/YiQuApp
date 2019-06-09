import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/widgets/IconButtonWidget.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
import 'package:yiqu/widgets/TextInputWidget.dart';
// import 'package:yiqu/widgets/TosatWidget.dart';

class AddIdlePage extends StatefulWidget {
  @override
  _AddIdlePageState createState() => _AddIdlePageState();
}

class _AddIdlePageState extends State<AddIdlePage> {
  Idle _preIdle = new Idle(kimono);
  var _imgPath;
  String _currentLable;
  List<File> _images = new List<File>();

  Widget _addImage(path) {
    if (_imgPath != null) {
      return ImageBlockWidget(
        width: 100.0,
        height: 100.0,
        image: Image.file(_imgPath).image,
      );
    } else {
      // showToast("  你取消了选择图片 ヽ(ー_ー)ノ  ");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _preIdle.labels = List();
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
      if (_imgPath != null) _images.add(image);
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
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
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 添加照片
                Padding(
                  child: Text("添加照片*", style: AppTheme.titleTextStyle),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 120.0,
                      child: FlatButton(
                        color: AppTheme.widgetBackground,
                        onPressed: _takePhoto,
                        child: Icon(Icons.add_a_photo,
                            size: 36.0, color: AppTheme.inactive),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    Container(
                      height: 100.0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.file(_images[index], height: 300);
                          }),
                    ),

                    // 添加图片控件
                  ],
                ),

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
                          style: AppTheme.inactiveTextStyle
                              .copyWith(fontSize: 16.0)),
                    ),
                    Expanded(
                      child: TextInputWidget(
                        borderRadius: 50.0,
                        isDigital: true,
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

                // Positioned(
                //   child: null,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog _addLabelDialog() {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.edit, size: 20.0),
          SizedBox(width: 8.0),
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
}
