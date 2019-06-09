import 'package:flutter/material.dart';
import 'package:yiqu/data/AppConfig.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData menuIconData;
  final String menuLabel;
  final VoidCallback onPressed;
  final bool isNeedRightArrow;

  const MenuItemWidget({
    Key key,
    this.menuIconData,
    this.menuLabel,
    this.onPressed,
    this.isNeedRightArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(menuIconData),
                  SizedBox(width: 8.0),
                  Text(menuLabel, style: AppTheme.titleTextStyle),
                ],
              ),
              Builder(
                builder: (BuildContext context) {
                  return isNeedRightArrow ? Icon(Icons.chevron_right) : null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
