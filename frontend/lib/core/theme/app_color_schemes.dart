import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

final class AppColorSchemes {
  AppColorSchemes._();
  static final lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary, // buttons, active elements
    onPrimary: Colors.white, // text/icons on primary
    secondary: AppColors.success, // optional accent
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.background, // cards, dialogs, sheets
    onSurface: AppColors.textPrimary,
  );
}
