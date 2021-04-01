import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final double radius;
  final IconData iconData;
  final Function onTap;

  CustomIconButton({
    this.radius, this.iconData, this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: Icon(iconData),
      onPressed: onTap,
    );
  }
}
