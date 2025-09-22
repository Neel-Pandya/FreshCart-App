import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_color_schemes.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTheme {
  AppTheme._();
  static final textTheme = GoogleFonts.robotoTextTheme();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: textTheme,
    colorScheme: AppColorSchemes.lightColorScheme,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    colorScheme: AppColorSchemes.darkColorScheme,
  );
}
