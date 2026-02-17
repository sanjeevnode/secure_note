import 'package:flutter/material.dart';
import 'package:secure_note/src/core/core.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size,
    this.color,
    this.strokeWidth,
    this.backgroundColor,
  });

  final double? size;
  final Color? color;
  final double? strokeWidth;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 28;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? AppColors.tealPrimary,
        strokeWidth: strokeWidth ?? 3,
        backgroundColor: backgroundColor ?? AppColors.emeraldPrimary,
      ),
    );
  }
}
