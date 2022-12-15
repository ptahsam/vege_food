import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/config/palette.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final void Function() onPressed;
  final Color iconColor;

  const CircleButton(
      {Key? key,
        required this.icon,
        required this.iconSize,
        required this.onPressed,
        this.iconColor = Colors.grey
      }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: iconSize,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        color: Palette.primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
