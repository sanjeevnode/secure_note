import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key, this.size = AppConstants.appIconSize});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryGradient),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Center(
        child: Icon(
          Icons.shield_outlined,
          color: AppColors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}
