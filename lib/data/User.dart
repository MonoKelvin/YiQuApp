import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yiqu/data/Idle.dart';

/// TODO: 需要数据库 MySQL
/// 用户的数据
class User {
  final String uuid = Uuid().v1();
  String _userName; //用户名
  String _password; //密码
  String _address = ""; //地址
  Image headImage; //头像
  String gender; //性别
  String signiture; //签名

  // TODO: 只保存 commodity 的 UUID 方便数据库查询
  List<Idle> myCollection = List<Idle>(); //我的收藏

  User(
    this._userName,
    this._password, {
    this.headImage =
        const Image(image: AssetImage("assets/images/boy_for_user.png")),
    this.gender = "男",
    this.signiture = "这个人懒死了，都没有想说的话 o(︶︿︶)o",
  });

  String get getPassword => _password;
  String get getUserName => _userName;
  String get getAddress => _address;

  set setPassword(String password) => _password = password;
  set setUserName(String userName) => _userName = userName;
  set setAddress(String address) => _address = address;

  /// 刷新内容到json文件中，如果没有用户文件则报错，令用户重新登录或注册
  void freshToJsonFile() {
    // UserJson json;
    // FileOperation.saveJsonToFile(json.toJson(), "jsons");
  }

  static final User boyUser = User(
    "",
    "",
  );

  static final User girlUser = User(
    "",
    "",
    headImage: Image(image: AssetImage("assets/images/girl_for_user.png")),
  );
}
