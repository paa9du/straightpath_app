import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.coral,
      brightness: Brightness.light,
      primary: AppColors.ink,
      surface: Colors.white,
    ),
    textTheme: AppTypography.textTheme,
    splashFactory: InkRipple.splashFactory,
    splashColor: AppColors.coral.withValues(alpha: .28),
    highlightColor: AppColors.coral.withValues(alpha: .14),
    hoverColor: AppColors.coral.withValues(alpha: .08),
    focusColor: AppColors.coral.withValues(alpha: .12),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.field),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.field),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.field),
        borderSide: const BorderSide(color: AppColors.coral),
      ),
    ),
  );
}
