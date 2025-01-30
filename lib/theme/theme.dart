import 'package:flutter/material.dart';

abstract class AppColors {
  static const bgLight = Color(0xfff6f6f6);
  static const bgDark = Color.fromARGB(255, 29, 1, 43);
  static const primary = Color(0xFF53FF59);
  static const onPrimary = Color(0x00A5FF4C);
  static const secondary = Color(0xFF5900FF);
  static const onSecondary = Color(0xA35900FF);
  static const error = Color(0xFFFF0606);
  static const onError = Color(0xC3FF0606);
  static const surface = Color(0xFF330648); //This is the background color
  static const onSurface = Color(0xC4330648);
  static const textColor = Color(0xffffffff);
}

ThemeData customTheme = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface),
  textTheme: TextTheme(
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: const Color(0xFFE8E8E8), fontSize: 12),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffffffff), size: 28),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStatePropertyAll(
      Color(0xffffffff),
    ),
    checkColor: WidgetStatePropertyAll(
      const Color(0xFF52C455),
    ),
  ),
);
