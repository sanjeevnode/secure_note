import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.onBack,
    this.background,
    this.actions,
    this.showBackButton = false,
    this.leading,
  });

  final String? title;
  final void Function()? onBack;
  final bool showBackButton;
  final Color? background;
  final List<Widget>? actions;
  final List<Widget>? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? AppColors.white,
        border: const Border(
          bottom: BorderSide(color: AppColors.grayBorder, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              width: double.infinity,
              height: kToolbarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),

              child: Row(
                children: [
                  if (showBackButton) ...[
                    Clickable(
                      child: const Icon(
                        Icons.arrow_back_ios_sharp,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                      onTap: () {
                        onBack?.call();
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 12),
                  ],

                  if (leading != null) ...leading!,

                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: AppTextStyle.textLgSemibold.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
