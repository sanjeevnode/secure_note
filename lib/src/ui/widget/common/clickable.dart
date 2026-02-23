import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final void Function(bool)? onHover;

  const Clickable({super.key, required this.child, this.onTap, this.onHover});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        onHover?.call(true);
      },
      onExit: (event) {
        onHover?.call(false);
      },
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
