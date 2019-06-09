import 'package:uuid/uuid.dart';
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/data/AppConfig.dart';

/// 商品的交易类型
enum EIdleType {
  ///只限于交换
  Change,

  ///只限于出售
  Sell,

  ///免费赠送的，目前不要实现它
  Free,
}

class Idle {
  /// #### 全球唯一标识
  /// 每件商品唯一标识，用于`数据库查询`
  ///
  /// 该方法是基于时间生成的 UUID，详情看官网 http://tools.ietf.org/html/rfc4122.html#section-4.2.2
  final String uuid = Uuid().v1();

  /// #### 商品的图像
  /// 限于 `9` 张。
  List<Image> images = List<Image>();

  /// #### 该商品的拥有者（发布者）
  final User _user;

  /// #### 发布时取的标题
  String title;

  /// #### 描述信息
  String description;

  /// #### 发布的时间
  DateTime timeOfTheDay;

  /// #### 所属的分类
  String category;

  /// #### 交易的类型
  EIdleType idleType = EIdleType.Sell;

  /// #### 商品的价格
  /// 只有当 `commodityType` 是 `ECommodityType.Sell` 该值有效
  double price = 0.0;

  //点赞（满意）数量
  int satisfiedCount = 0;

  List<String> labels = List<String>();

  Idle(
    this._user, {
    this.images,
    this.price,
    this.labels,
    @required this.title,
    @required this.description,
    @required this.idleType,
    @required this.category,
  }) {
    timeOfTheDay = DateTime.now();
    if (idleType != EIdleType.Sell) {
      price = 0.0;
    }
  }

  String getMonthAndDay() {
    String mad = timeOfTheDay.toString();
    return mad.split(" ")[0];
  }

  User get getUser => _user;

  /// #### 添加图片
  /// 只允许添加 `9` 张
  void addImage(Image img) {
    if (images.length < 9) images.add(img);
  }

  bool isExistByUuid(String otherUuid) {
    if (otherUuid == uuid) {
      return true;
    }
    return false;
  }

  bool isExistByCommodity(Idle commodity) {
    if (commodity.uuid == uuid) {
      return true;
    }
    return false;
  }
}
