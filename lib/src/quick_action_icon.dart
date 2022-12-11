import 'package:flutter/material.dart';

class QuickActionIcon extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;

  const QuickActionIcon({
    required this.icon,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: icon,
      ),
    );
  }
}
