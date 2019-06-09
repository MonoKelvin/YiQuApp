import 'package:flutter/material.dart';

/// 定制的圆角图片，用以展示首页的商品信息或在添加物品模块的 “添加照片”
class ImageBlockWidget extends StatelessWidget {
  final ImageProvider image;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback onTap;

  const ImageBlockWidget({
    Key key,
    @required this.image,
    this.width = 100.0,
    this.height = 100.0,
    this.borderRadius = 8.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,

        // 圆角效果
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
