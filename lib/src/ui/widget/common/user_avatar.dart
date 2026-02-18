import 'package:flutter/material.dart';
import 'package:secure_note/src/core/core.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.userName, this.size = 28});
  final String? userName;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initialsText = getInitials(userName);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grayDark,
        border: Border.all(color: AppColors.grayDarkest, width: .5),
      ),
      child: Center(
        child: initialsText.isEmpty
            ? Icon(Icons.person, size: size * 0.5, color: AppColors.white)
            : Text(
                initialsText,
                style: AppTextStyle.textMdMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
