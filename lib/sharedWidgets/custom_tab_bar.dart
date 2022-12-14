import 'package:flutter/material.dart';
import 'package:vege_food/config/palette.dart';

class CustomTabBar extends StatelessWidget {

  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  const CustomTabBar({
    Key? key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Palette.primaryColor,
            width: 3.0,
          )
        ),
      ),
      tabs: icons.asMap()
          .map((i, e) => MapEntry(i, Tab(
        icon: Icon(e, color: i == selectedIndex?Palette.primaryColor:Colors.grey, size: 28.0,),
      ))).values.toList(),
      onTap: onTap,
    );
  }
}
