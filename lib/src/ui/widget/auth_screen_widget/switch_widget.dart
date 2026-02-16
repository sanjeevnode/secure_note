import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.cuurrentIndex = AuthConstants.loginIndex,
    this.onIndexChanged,
  });
  final int cuurrentIndex;
  final void Function(int)? onIndexChanged;
  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  int get cuurrentIndex => widget.cuurrentIndex;

  void onIndexChanged(int index) {
    if (index != cuurrentIndex) {
      widget.onIndexChanged?.call(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.switchBackground,
        borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
      ),
      padding: const EdgeInsets.all(2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final switchWidth = constraints.maxWidth * 0.5;
          return Row(
            children: [
              Clickable(
                onTap: () => onIndexChanged(AuthConstants.loginIndex),
                child: Container(
                  width: switchWidth,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cuurrentIndex == AuthConstants.loginIndex
                        ? AppColors.white
                        : AppColors.switchBackground,
                    borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadius,
                    ),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    AuthConstants.loginText,
                    style: AppTextStyle.textLgRegular,
                  ),
                ),
              ),
              Clickable(
                onTap: () => onIndexChanged(AuthConstants.registerIndex),
                child: Container(
                  width: switchWidth,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cuurrentIndex == AuthConstants.registerIndex
                        ? AppColors.white
                        : AppColors.switchBackground,
                    borderRadius: BorderRadius.circular(
                      AppConstants.appBorderRadius,
                    ),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    AuthConstants.registerText,
                    style: AppTextStyle.textLgRegular,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
