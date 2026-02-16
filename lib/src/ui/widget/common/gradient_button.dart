import 'package:flutter/material.dart';
import 'package:secure_note/src/src.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.onSubmit,
    required this.label,
    this.buttonStyle,
    this.gradient,
    this.textStyle,
  });

  final void Function()? onSubmit;
  final String label;
  final ButtonStyle? buttonStyle;
  final Gradient? gradient;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            gradient ??
            const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(
          AppConstants.appBorderRadius,
        ), // match button radius
      ),
      child: ElevatedButton(
        style:
            buttonStyle ??
            ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.appBorderRadius,
                ),
              ),
            ),
        onPressed: onSubmit,
        child: Text(
          label,
          style:
              textStyle ??
              AppTextStyle.textLgSemibold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
