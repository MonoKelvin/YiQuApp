import 'package:flutter/material.dart';
import 'package:yiqu/data/User.dart';
// import 'package:yiqu/data/AppConfig.dart';
import 'package:yiqu/pages/UserPage.dart';
import 'package:yiqu/widgets/ImageBlockWidget.dart';

class HeadIconWidget extends StatelessWidget {
  final User user;
  final double radius;
  final bool isRoutePage;

  const HeadIconWidget({
    Key key,
    @required this.user,
    this.radius = 40.0,
    this.isRoutePage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isRoutePage?() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UserPage(
                      user: user,
                    )));
      }:null,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageBlockWidget(
              width: radius,
              height: radius,
              borderRadius: radius,
              image: user.headImage.image,
            ),
          ],
        ),
      ),
    );
  }
}
