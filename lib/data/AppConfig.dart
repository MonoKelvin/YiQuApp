import 'package:flutter/material.dart';
import 'package:yiqu/data/Idle.dart';
import 'package:yiqu/data/User.dart';
import 'package:yiqu/pages/SendMessagePage.dart';

/// #### 所有商品的分类
/// 下次要添加其他类别，直接在文件 `package:yiqu/data/AppConfig.dart` 中添加
List<String> categories = [
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
  static const Color widgetBackground = Color.fromRGBO(248, 248, 252, 1.0);

  /// App主要的黑色
  static const Color mainDark = Color.fromRGBO(60, 60, 70, 1.0);

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
  static const Color subTitle = Color.fromRGBO(120, 120, 136, 1.0);
  static const Color activeWhenPressed = Color.fromRGBO(170, 170, 180, 1.0);
  static const Color inactive = Color.fromRGBO(220, 220, 226, 1.0);

  static const TextStyle largeTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: mainDark,
  );

  static const TextStyle foregroundTextStyle = TextStyle(
    fontSize: 12.0,
    color: mainBackground,
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

User myself = new User();
User friend = new User();

class Message {
  bool isMe;
  String contents;
  String time;

  Message({@required this.isMe, @required this.contents, @required this.time});
}

class AppData {
  static Map<User, List<Message>> messagesList = ({});
  //Map<User, List<ChatMessage>>;

  // 6个用户 + myself
  static List<User> allUsers = [
    User.create(
      "天才小熊猫",
      "asd792a",
      "passwor",
      "",
      Image.network(
        "https://img2.woyaogexing.com/2019/06/11/7485a48307e736df!400x400_big.jpg",
        fit: BoxFit.cover,
      ),
      "男",
      "",
    ),
    User.create(
      "目色三",
      "asd79211",
      "password",
      "安徽省合肥市合肥工业大学屯溪路校区",
      Image.network(
        "https://img2.woyaogexing.com/2019/06/11/c3d150ab802641eb8ff07b0eeda83b07!400x400.jpeg",
        fit: BoxFit.cover,
      ),
      "男",
      "",
    ),
    User.create(
      "柳然是魔鬼",
      "asdqwe",
      "123456",
      "安徽省宣城市宣州区合肥工业大学",
      Image.network(
        "https://img2.woyaogexing.com/2019/06/11/ad15fa0b971e2fa5!400x400_big.jpg",
        fit: BoxFit.cover,
      ),
      "女",
      "",
    ),
    User.create(
      "美国队长",
      "15007083506",
      "222222",
      "合肥工业大学宣城校区三号宿舍楼",
      Image.network(
        "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=4241417337,1057509416&fm=26&gp=0.jpg",
        fit: BoxFit.cover,
      ),
      "男",
      "I can do this all day!",
    ),
    User.create(
      "XRDS0909",
      "89745@qq.com",
      "123123",
      "合肥工业大学三号宿舍419",
      Image.network(
        "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1560246423&di=93c25b0dd009eea3973d0e123678db88&src=http://img3.duitang.com/uploads/item/201605/07/20160507191419_J2m8R.thumb.700_0.jpeg",
        fit: BoxFit.cover,
      ),
      "男",
      "走自己的路，让别人说去吧",
    ),
    User.create(
      "asd8976",
      "4302@163.com",
      "123123",
      "合肥工业大学四号宿舍420",
      Image.network(
        "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3702304829,2844936810&fm=26&gp=0.jpg",
        fit: BoxFit.cover,
      ),
      "男",
      "I can do this all day!",
    ),
  ];

// TODO: 不应该直接给出，应要动态创建内容
  /// #### 我的所有商品
  static List<Idle> allIdles = [
    Idle(
      AppData.allUsers[0],
      title: "高等数学同济版上下册",
      category: categories[3],
      labels: ["书", "图书文具"],
      price: 43.00,
      idleType: EIdleType.Sell,
      description: "学长特别处理高等数学教材了，同济版较为简单",
      images: [
        Image.network(
          "https://img.alicdn.com/imgextra/i2/2468631159/TB2i1tchmtkpuFjy0FhXXXQzFXa_!!2468631159.jpg", //只改这个地方，填入图片链接。
          fit: BoxFit.cover,
        ),
        Image.network(
          "https://img.alicdn.com/imgextra/i4/2468631159/TB2JTbRixxmpuFjSZFNXXXrRXXa_!!2468631159.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[1], //所属用户，暂不用改
      title: "统一汤达人方便面袋装泡面整箱酸辣豚骨拉面罗宋汤共15包", //标题，如：魅族蓝牙耳机
      category: categories[6], //分类看下面，从0开始编号，选择一个分类
      labels: [
        //标签，如："耳机", "电子产品"
        "泡面",
        "美食"
      ],
      price: 51.00, //价格，保留两位小数，如：233.33
      idleType: EIdleType.Sell, //发布闲置的类型，暂不用改
      description:
          "双十一买了好多箱结果买多吃不完了，现在特别处理一箱泡面", //描述，如："本想运动时戴，可惜懒癌附体，一年下来也没动过，耳机几乎放着吃灰"
      images: [
        //图片，只改"xxx"内的图片网络链接，如："https://cdn.xxx.com/xxx.jpg", 可以添加多个图片，按照格式添加。
        Image.network(
          "https://img.alicdn.com/imgextra/i4/1014978183/TB2fUOTAr9YBuNjy0FgXXcxcXXa_!!1014978183.jpg", //只改这个地方，填入图片链接。
          fit: BoxFit.cover, //图片缩放类型，不要改
        ),
        Image.network(
          "https://img.alicdn.com/imgextra/i2/1014978183/TB2lZX5AAyWBuNjy0FpXXassXXa_!!1014978183.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[2],
      title: "洗发水",
      category: categories[0],
      labels: ["日用品", "生活用品"],
      price: 20.00,
      idleType: EIdleType.Sell,
      description: "洗发水买多了，低价出售",
      images: [
        Image.network(
          "http://cdimg.good.cc/images/MainImg/0x0/0/4352/4352815.jpg_w300.jpg?r=519202721",
          fit: BoxFit.cover, //图片缩放类型，不要改
        ),
      ],
    ),
    Idle(
      AppData.allUsers[3],
      title: "单反相机",
      category: categories[1],
      labels: ["照相机", "数码产品"],
      price: 3999.00,
      idleType: EIdleType.Sell,
      description: "全新单反，低价出售",
      images: [
        Image.network(
          "http://img003.hc360.cn/g8/M08/AC/0C/wKhQtVNHdMOETKdCAAAAAJu1adg112.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[4],
      title: "混沌摆",
      category: categories[2],
      labels: ["摆件装饰", "趣物"],
      price: 200.00,
      idleType: EIdleType.Sell,
      description: "这个没什么用，有想要的直接拿走",
      images: [
        Image.network(
          "http://img.go007.com/2017/12/11/5606d0916d1b626f_0.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[5],
      title: "人性的弱点",
      category: categories[3],
      labels: ["书籍", "读物"],
      price: 10.00,
      idleType: EIdleType.Sell,
      description: "读完了，九成新，有意者联系",
      images: [
        Image.network(
          "http://m.360buyimg.com/n12/18270/735ea0e2-0dcd-4e1a-bbcd-d3320ec1e3cc.jpg%21q70.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      myself,
      title: "跳绳",
      category: categories[4],
      labels: ["运动用品", "体育用品"],
      price: 2.00,
      idleType: EIdleType.Sell,
      description: "不想要了，速度出了",
      images: [
        Image.network(
          "http://img005.hc360.cn/g7/M05/51/8D/wKhQtFQB2aiEHzFzAAAAAOr1YFM617.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[0],
      title: "握力器",
      category: categories[5],
      labels: ["运动用品", "体育用品"],
      price: 20.00,
      idleType: EIdleType.Sell,
      description: "不想要了，速度出了",
      images: [
        Image.network(
          "http://fs1.shop123.com.tw/300135/upload/product/3001354112pic_outside_969679.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
    Idle(
      AppData.allUsers[3],
      title: "Nike 耐克官方NIKE LEGEND TRAINER男子训练鞋 924206",
      category: categories[5],
      labels: [
        "运动鞋",
        "运动用品"
      ],
      price: 389.00,
      idleType: EIdleType.Sell,
      description:
          "买来穿了几次而已，发现不合脚想要卖出去",
      images: [
        Image.network(
          "https://img.alicdn.com/imgextra/i4/890482188/O1CN01OziFQp1S294DQaFCa_!!890482188.jpg", //只改这个地方，填入图片链接。
          fit: BoxFit.cover,
        ),
        Image.network(
          "https://img.alicdn.com/imgextra/i4/890482188/O1CN017JnhCh1S295VY7uIi_!!890482188.jpg",
          fit: BoxFit.cover,
        ),
      ],
    ),
  ];
}
