import 'package:flutter/material.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/data/User.dart';

/// #### 所有商品的分类
/// 下次要添加其他类别，直接在文件 `package:yiqu/data/AppConfig.dart` 中添加
List<String> categories = [
  '全部',
  '生活用品',
  '电子数码',
  '摆件装饰',
  '图书文具',
  '运动器材',
  '体育用品',
  '其它'
];

/// #### 调试用的 Andoid 模拟器的像素密度为 `2.0`
///
/// 所有在PS中设计好的尺寸（以px为单位）转换到 flutter 里必须进行计算为dp单位
///
/// #### 计算公式：
/// ```
///    dp = px / pixelRadio
/// ```
/// PS中显示 `36` 的字体大小在 `flutter` 使用时，应当写成 `36px / 2.0 = 18.0dp`
///
class AppTheme {
  /// 基本控件的背景色
  static const Color widgetBackground = Color.fromRGBO(245, 245, 248, 1.0);

  /// App主要的黑色
  static const Color mainDark = Color.fromRGBO(60, 60, 68, 1.0);

  /// App主要的蓝色
  static const Color mainBlue = Color.fromRGBO(70, 184, 255, 1.0);

  /// App主要的红色
  static const Color mainRed = Color.fromRGBO(255, 64, 106, 1.0);

  /// App主要的绿色
  static const Color mainGreen = Color.fromRGBO(68, 219, 135, 1.0);

  /// 主要的背景色
  static const Color mainBackground = Colors.white;

  static const Color blueCardShadow = Color.fromRGBO(181, 213, 226, 0.5);
  static const Color blueButtonShadow = Color.fromRGBO(70, 184, 255, 0.5);
  static const Color redShadow = Color.fromRGBO(255, 64, 106, 0.5);
  static const Color alertBackground = Color.fromRGBO(255, 64, 106, 0.1);
  static const Color subTitle = Color.fromRGBO(120, 120, 130, 1.0);
  static const Color activeWhenPressed = Color.fromRGBO(170, 170, 180, 1.0);
  static const Color inactive = Color.fromRGBO(218, 218, 225, 1.0);

  static const TextStyle largeTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: mainDark,
  );

  static const TextStyle alertTextStyle = TextStyle(
    fontSize: 16.0,
    color: mainRed,
  );

  static const TextStyle bigestTextStyle = TextStyle(
    // fontWeight: FontWeight.bold,
    fontSize: 32.0,
    color: mainDark,
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: mainDark,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 12.0,
    color: subTitle,
  );

  static const TextStyle subTextStyle = TextStyle(
    fontSize: 10.0,
    color: activeWhenPressed,
  );

  static const TextStyle inactiveTextStyle = TextStyle(
    fontSize: 10.0,
    color: inactive,
  );

  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 10.0,
    color: mainDark,
  );

  static const TextStyle messageTextStyle = TextStyle(
    fontSize: 14.0,
    color: mainBackground,
  );

  static const TextStyle friendMessageTextStyle = TextStyle(
    fontSize: 14.0,
    color: mainDark,
  );

  static const IconThemeData iconActiveStyle = IconThemeData(
    size: 24.0,
    color: mainDark,
  );
}

User kimono = User("Kimono", "123456",
    headImage: Image.network(
      "https://cdn.pixabay.com/photo/2016/04/10/21/34/woman-1320810_960_720.jpg",
      fit: BoxFit.cover,
    ));

// TODO: 不应该直接给出，应要动态创建内容
/// #### 我的所有商品
List<Idle> myIdles = [
  Idle(
    kimono,
    title: "魅族EP51蓝牙耳机",
    category: categories[2],
    labels: [
      categories[2],
      "耳机",
      "魅族"
    ],
    price: 99.00,
    idleType: EIdleType.Sell,
    description: "本想运动时戴，可惜懒癌附体，一年下来也没动过，耳机几乎放着吃灰。",
    images: [
      Image.network(
        "https://cdn.pixabay.com/photo/2015/03/17/14/05/sparkler-677774_960_720.jpg",
        fit: BoxFit.cover,
      ),
      Image.network(
        "https://cdn.pixabay.com/photo/2019/05/09/19/13/meteora-4191906_960_720.jpg",
        fit: BoxFit.cover,
      ),
      Image.network(
        "https://cdn.pixabay.com/photo/2018/09/16/12/29/sailing-vessel-3681418_960_720.jpg",
        fit: BoxFit.cover,
      ),
    ],
  ),
  Idle(
    kimono,
    title: "YSL方管小金条21圣罗兰杨树林口红",
    category: categories[3],
    labels: [
      categories[3],
      "口红",
      "化妆品"
    ],
    price: 149.00,
    idleType: EIdleType.Change,
    description: "品牌型号:圣罗兰新旧程度:全新转手原因:朋友给带的口红不太适合自己，送给有缘人",
    images: [
      Image.network(
        "https://cdn.pixabay.com/photo/2018/09/16/12/29/sailing-vessel-3681418_960_720.jpg",
        fit: BoxFit.cover,
      ),
    ],
  ),
  Idle(
    kimono,
    title: "铁艺服装架服装店衣架展示架落地式女装店陈列中岛架",
    category: categories[3],
    labels: [
      categories[3],
      "衣架",
      "女装",
      "装饰"
    ],
    price: 104.65,
    idleType: EIdleType.Sell,
    description: "颜色分类F款【长55】",
    images: [
      Image.network(
        "https://cdn.pixabay.com/photo/2019/05/09/19/13/meteora-4191906_960_720.jpg",
        fit: BoxFit.cover,
      ),
    ],
  ),
  Idle(
    kimono,
    title: "ysl唇釉12",
    category: categories[3],
    labels: [
      categories[3],
      "化妆品",
      "口红"
    ],
    price: 150.00,
    idleType: EIdleType.Sell,
    description: "圣罗兰金管唇釉12 自用正品 掉漆 余量如图 可以买回去试色用 价格可商量",
    images: [
      Image.network(
        "https://cdn.pixabay.com/photo/2016/04/10/21/34/woman-1320810_960_720.jpg",
        fit: BoxFit.cover,
      ),
    ],
  ),
  Idle(
    kimono,
    title: "施华洛世奇项链",
    category: categories[1],
    labels: [
      categories[1],
      "项链",
      "首饰"
    ],
    price: 200.00,
    idleType: EIdleType.Sell,
    description: "去年八月中旬月份买的，因为脖子粗了，待着不好看。有喜欢的宝宝，可以看一下保证正品小天鹅",
    images: [
      Image.network(
        "https://cdn.pixabay.com/photo/2018/09/16/12/29/sailing-vessel-3681418_960_720.jpg",
        fit: BoxFit.cover,
      ),
    ],
  ),
];
