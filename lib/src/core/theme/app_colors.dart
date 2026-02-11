import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Primary Brand Colors
  static const tealPrimary = Color(0xFF14B8A6);
  static const tealHover = Color(0xFF0D9488);
  static const tealDark = Color(0xFF0F766E);
  static const emeraldPrimary = Color(0xFF059669);
  static const emeraldHover = Color(0xFF047857);

  // Neutral Colors (Grayscale)
  static const white = Color(0xFFFFFFFF);
  static const grayLightest = Color(0xFFF8FAFC);
  static const grayLight = Color(0xFFF1F5F9);
  static const grayBorder = Color(0xFFE2E8F0);
  static const grayBorderDark = Color(0xFFCBD5E1);
  static const grayIcon = Color(0xFF94A3B8);
  static const grayMedium = Color(0xFF64748B);
  static const grayDark = Color(0xFF475569);
  static const grayDarker = Color(0xFF334155);
  static const grayDarkest = Color(0xFF0F172A);
  static const primaryDark = Color(0xFF030213);

  // Blue Accent
  static const blueLight = Color(0xFFEFF6FF);

  // Red (Destructive)
  static const redLight = Color(0xFFFEF2F2);
  static const redBorder = Color(0xFFFECACA);
  static const redPrimary = Color(0xFFDC2626);
  static const redDark = Color(0xFFB91C1C);
  static const redDestructive = Color(0xFFD4183D);

  // Teal Accent
  static const tealLightest = Color(0xFFF0FDFA);

  // Emerald Accent
  static const emeraldLightest = Color(0xFFECFDF5);

  // Muted Colors
  static const mutedBackground = Color(0xFFECECF0);
  static const mutedText = Color(0xFF717182);
  static const inputBackground = Color(0xFFF3F3F5);
  static const switchBackground = Color(0xFFCBCED4);

  // Shadow Colors
  static const cardShadow = Color(0xFFE2E8F0);

  // Gradients as Color Lists
  static const primaryGradient = [tealPrimary, emeraldPrimary];
  static const primaryGradientHover = [tealHover, emeraldHover];
  static const avatarGradient = [grayDarker, grayDarkest];
  static const pageBackgroundGradient = [grayLightest, grayLight, blueLight];
  static const cardIconGradient = [grayLight, grayBorder];
  static const cardIconGradientHover = [tealLightest, emeraldLightest];
}
