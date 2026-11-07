import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextTheme get textTheme => const TextTheme(
    displaySmall: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 28,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 24,
      height: 1.35,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 20,
      height: 1.35,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 18,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 14,
      height: 1.45,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 12,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
