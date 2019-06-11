import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/utilities/Utilities.dart';

/// TODO: 需要数据库 MySQL
/// 用户的数据
class User {
  String _uuid = Uuid().v1();
  String _userName; //用户名
  String _account; //账号
  String _password; //密码
  String _address = ""; //地址
  Image headImage; //头像
  String gender; //性别
  String signiture; //签名

  // TODO: 只保存 commodity 的 UUID 方便数据库查询
  List<Idle> myCollection = List<Idle>(); //我的收藏

  User({
    this.headImage =
        const Image(image: AssetImage("assets/images/boy_for_user.png")),
    this.gender = "男",
    this.signiture = "这个人懒死了，都没有想说的话 o(︶︿︶)o",
  });

  User.create(this._userName, this._account, this._password, this._address,
      this.headImage, this.gender, this.signiture) {
    if (!isValidTextInput(this.signiture))
      this.signiture = "这个人懒死了，都没有想说的话 o(︶︿︶)o";
  }

  String get getUserName => _userName;
  String get getAccount => _account;
  String get getPassword => _password;
  String get getAddress => _address;
  String get getUuid => _uuid;

  set setUserName(String userName) => _userName = userName;
  set setAccount(String account) => _account = account;
  set setPassword(String password) => _password = password;
  set setAddress(String address) => _address = address;

  static final User boyUser = User(
      headImage: Image(
    image: AssetImage("assets/images/boy_for_user.png"),
  ));

  static final User girlUser = User(
    headImage: Image(image: AssetImage("assets/images/girl_for_user.png")),
  );

  User.fromJson(Map<String, dynamic> json) {
    this._uuid = json['uuid'];
    _userName = json['userName'];
    _account = json['account'];
    _password = json['password'];
    _address = json['address'];
    headImage = Image.network(json['headImage']);
    gender = json['gender'];
    signiture = json['signiture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this._uuid;
    data['userName'] = this._userName;
    data['account'] = this._account;
    data['password'] = this._password;
    data['address'] = this._address;
    data['headImage'] = this.headImage;
    data['gender'] = this.gender;
    data['signiture'] = this.signiture;
    return data;
  }

  /// #### 将 `本地的json` 字符串解析为 User 对象
  /// `[fileName]`文件名，默认在`assets/datas`文件夹下，故只要写文件名即可，如：
  ///
  /// `user.jon` 或 `myfile.txt`
  ///
  /// 不要写成 `datas/user.jon`
  static Future<User> getDataFromJson(String fileName) async {
    var str = rootBundle.loadString("assets/datas/$fileName").toString();
    //var str = await File("assets/datas/$fileName").readAsString();
    var user = User.fromJson(json.decode(str));
    return user;
  }

  /// 刷新内容到json文件中，如果没有用户文件则报错，令用户重新登录或注册
  void freshToJsonFile(String fileName) {
    File("assets/datas/$fileName").writeAsStringSync(this.toJson().toString());
  }
}
