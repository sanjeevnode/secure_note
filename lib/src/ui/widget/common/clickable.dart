import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const Clickable({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
