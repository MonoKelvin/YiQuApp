import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

class DashLineWidget extends StatelessWidget {
  final double width;
  final double height;
  final double spacing;
  final Color color;

  const DashLineWidget({
    this.height = 2.0,
    this.width = 12.0,
    this.spacing = 1.5,
    this.color = AppTheme.widgetBackground,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (1.5 * width)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: width,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
