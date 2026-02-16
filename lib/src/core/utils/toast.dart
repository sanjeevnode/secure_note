import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class Toast {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldKey;

  static SnackBar _snackBar({
    required Widget content,
    required Color color,
    Duration? duration,
  }) {
    return SnackBar(
      content: content,
      backgroundColor: color,
      showCloseIcon: true,
      closeIconColor: AppColors.primaryDark,
      duration: duration ?? _defaultDuration,
      dismissDirection: DismissDirection.startToEnd,
      behavior: SnackBarBehavior.floating,
      padding: _padding,
      margin: const EdgeInsets.all(20),
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.blueLight, width: 1),
        borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
      ),
    );
  }

  static const _defaultDuration = Duration(seconds: 3);
  static const _padding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static void error(String message, {Duration? duration}) =>
      _showToast(message, icon: _buildIcon(3), duration: duration);

  static void success(String message, {Duration? duration}) =>
      _showToast(message, icon: _buildIcon(1), duration: duration);

  static void warning(String message, {Duration? duration}) =>
      _showToast(message, icon: _buildIcon(2), duration: duration);

  static void show(
    String message, {
    Duration? duration,
    Widget? icon,
    Color? backgroundColor,
    Color? textColor,
  }) => _showToast(
    message,
    icon: icon,
    duration: duration,
    textColor: textColor,
    backgroundColor: backgroundColor,
  );

  static void _showToast(
    String message, {
    Widget? icon,
    Duration? duration,
    Color? textColor,
    Color? backgroundColor,
  }) {
    final color = backgroundColor ?? AppColors.grayLightest;
    _scaffoldKey.currentState?.showSnackBar(
      _snackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[icon, const SizedBox(width: 10)],
            Flexible(
              child: Text(
                message,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textMdMedium.copyWith(
                  color: textColor ?? AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
        color: color,
        duration: duration,
      ),
    );
  }

  static Widget _buildIcon(int type) {
    switch (type) {
      case 1:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          padding: const EdgeInsets.all(4),
          child: const Icon(
            Icons.check_outlined,
            color: AppColors.white,
            size: 16,
          ),
        );
      case 2:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
          padding: const EdgeInsets.all(4),
          child: const Icon(
            Icons.warning_amber_outlined,
            color: AppColors.white,
            size: 16,
          ),
        );

      case 3:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.redDestructive,
          ),
          padding: const EdgeInsets.all(4),
          child: const Icon(
            Icons.close_outlined,
            color: AppColors.white,
            size: 16,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  /// Notification Toast
  static void notify({
    required String title,
    required String message,
    Duration? duration,
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
  }) {
    final color = backgroundColor ?? AppColors.grayLightest;
    _scaffoldKey.currentState?.showSnackBar(
      _snackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style:
                  titleStyle ??
                  AppTextStyle.textLgMedium.copyWith(
                    color: AppColors.primaryDark,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style:
                  messageStyle ??
                  AppTextStyle.textMdRegular.copyWith(
                    color: AppColors.primaryDark,
                  ),
            ),
          ],
        ),
        color: color,
        duration: duration,
      ),
    );
  }
}
