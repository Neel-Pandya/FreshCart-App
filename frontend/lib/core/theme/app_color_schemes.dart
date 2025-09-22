import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

final class AppColorSchemes {
  AppColorSchemes._();

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.success,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    onPrimary: Colors.black,
    secondary: AppColors.successDark,
    onSecondary: Colors.black,
    error: AppColors.errorDark,
    onError: Colors.black,
    surface: AppColors.cardBackgroundDark,
    onSurface: AppColors.textSecondaryDark,
  );
}
