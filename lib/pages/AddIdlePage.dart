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
  Idle _preIdle;
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
    // _currentLable = "";
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
                          barrierDismissible: false,
                        );
                      },
                    ),
                  ],
                ),
                Builder(
                  builder: (_) {
                    if (_preIdle.labels.isEmpty) {
                      return SizedBox(height: 16.0);
                    }
                    return Wrap(
                      children: _preIdle.labels.map((index) {
                        Chip(
                          label: Text(index),
                        );
                      }).toList(),
                    );
                  },
                )

                /*Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      onChanged: (bool value) {},
                      value: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Checkbox(
                          onChanged: (bool value) {},
                          value: true,
                        ),
                        Row(
                          children: <Widget>[
                            Text("定价"),
                            LineTextInputWidget(),
                            Text("元"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // 附加信息
                Padding(
                  child: Text("附加信息", style: AppTheme.titleTextStyle),
                  padding: EdgeInsets.only(),
                ),*/

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

  SimpleDialog _addLabelDialog() {
    return SimpleDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.edit, size: 20.0),
          SizedBox(width: 8.0),
          Text("添加标签", style: AppTheme.titleTextStyle),
        ],
      ),
      backgroundColor: AppTheme.mainBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      children: <Widget>[
        SimpleDialogOption(
          child: TextInputWidget(
            hintText: "标签名",
            maxLength: 8,
            onChanged: (String value) {
              setState(() {
                _currentLable = value;
              });
            },
          ),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButtonWidget(
                iconData: Icons.close,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                onPressed: () {},
              ),
              IconButtonWidget(
                iconData: Icons.check,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                onPressed: () {
                  _preIdle.labels.add(_currentLable);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
