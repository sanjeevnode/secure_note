import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.date,
  });

  final void Function()? onTap;
  final String title;
  final DateTime date;
  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: widget.onTap,
      onHover: (isHovered) {
        setState(() {
          this.isHovered = isHovered;
        });
      },
      child: Transform.scale(
        scale: isHovered ? 1.02 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
            border: Border.all(color: AppColors.grayBorder, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isHovered
                      ? AppColors.emeraldLightest
                      : AppColors.blueLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: isHovered
                        ? AppColors.emeraldHover
                        : AppColors.grayIcon,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.textMdSemibold,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.grayDarker,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDateMMMDYYYY(widget.date),
                          style: AppTextStyle.textSmRegular.copyWith(
                            color: AppColors.grayDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: isHovered ? AppColors.emeraldHover : AppColors.grayIcon,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
