import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yiqu/data/AppConfig.dart';
// import 'package:yiqu/data/Commodity.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';
import 'package:yiqu/widgets/LineTextInputWidget.dart';
// import 'package:yiqu/widgets/TosatWidget.dart';

class AddIdlePage extends StatefulWidget {
  @override
  _AddIdlePageState createState() => _AddIdlePageState();
}

class _AddIdlePageState extends State<AddIdlePage> {
  // Commodity _currentCommodity;
  var _imgPath;
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
                  hintText: "不超过24个字（包括标点符号）",
                  maxLength: 24,
                ),

                // 描述
                Padding(
                  child: Text("描述", style: AppTheme.titleTextStyle),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                Container(
                  height: 200.0,
                  child: TextInputWidget(
                    hintText: "描述你的宝贝，让更多人看到 ( • ̀ω•́ )✧",
                    borderRadius: 8.0,
                    maxLines: 1000,
                  ),
                ),

                // 标签
                Padding(
                  child: Text("标签", style: AppTheme.titleTextStyle),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),

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
}
