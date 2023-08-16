import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final Function? onPress;

  const IconButton({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        onPress!();
      },
      padding: const EdgeInsetsDirectional.all(0.0),
      minWidth: 0.0,
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
