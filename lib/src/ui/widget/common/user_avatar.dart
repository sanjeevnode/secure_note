import 'package:flutter/material.dart';
import 'package:secure_note/src/core/core.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.userName, this.size = 32});
  final String? userName;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initialsText = getInitials(userName);
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: AppColors.avatarGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: initialsText.isEmpty
            ? Icon(Icons.person, size: size * 0.5, color: AppColors.white)
            : Text(
                initialsText,
                style: AppTextStyle.textMdBold.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}
