import 'package:flutter/material.dart';
import 'package:secure_note/src/core/constants/constants.dart%20%20';
import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get standard {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.tealPrimary,
        onPrimary: AppColors.white,
        secondary: AppColors.emeraldPrimary,
        onSecondary: AppColors.white,
        error: AppColors.redDestructive,
        onError: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.primaryDark,
        surfaceContainerHighest: AppColors.grayLight,
        outline: AppColors.grayBorder,
        outlineVariant: AppColors.grayBorderDark,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.grayLightest,

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grayDarkest,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyle.textXlSemibold.copyWith(
          color: AppColors.grayDarkest,
        ),
        iconTheme: const IconThemeData(color: AppColors.grayDark),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: AppColors.grayLightest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          borderSide: const BorderSide(color: AppColors.grayBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          borderSide: const BorderSide(color: AppColors.grayBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          borderSide: const BorderSide(color: AppColors.tealPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          borderSide: const BorderSide(color: AppColors.redBorder, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          borderSide: const BorderSide(color: AppColors.redPrimary, width: 2),
        ),
        labelStyle: AppTextStyle.textMdMedium.copyWith(
          color: AppColors.grayDarker,
        ),
        hintStyle: AppTextStyle.textMdRegular.copyWith(
          color: AppColors.grayIcon,
        ),
        errorStyle: AppTextStyle.textSmRegular.copyWith(
          color: AppColors.redDark,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealPrimary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.tealPrimary.withAlpha(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyle.textMdSemibold,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.grayDarker,
          side: const BorderSide(color: AppColors.grayBorderDark, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyle.textMdSemibold,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.tealPrimary,
          textStyle: AppTextStyle.textMdSemibold,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.tealPrimary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.grayDark, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.grayBorder,
        thickness: 1,
        space: 1,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.tealPrimary;
          }
          return AppColors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.tealPrimary.withAlpha(126);
          }
          return AppColors.switchBackground;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.tealPrimary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.grayBorder, width: 2),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.tealPrimary;
          }
          return AppColors.grayBorder;
        }),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.grayDarkest,
        contentTextStyle: AppTextStyle.textMdRegular.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.appBorderRadius),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Page Transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class CustomBehaviour extends StatelessWidget {
  const CustomBehaviour({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior: const ScrollBehaviorModified(),
            child: child,
          ),
        ],
      ),
    );
  }
}
