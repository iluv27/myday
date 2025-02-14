import 'package:flutter/material.dart';
import 'package:myday/theme/bloc/theme_bloc.dart';
import 'package:myday/theme/theme.dart';

ThemeData buildTheme(AppTheme theme) {
  Color primaryColor;
  Color surfaceColor;

  switch (theme) {
    case AppTheme.red:
      primaryColor = Colors.red;
      surfaceColor = Colors.red.shade900;
      break;
    case AppTheme.green:
      primaryColor = Colors.green;
      surfaceColor = Colors.green.shade900;
      break;
    case AppTheme.purple:
      primaryColor = Colors.purple;
      surfaceColor = Colors.purple.shade900;
      break;
    case AppTheme.orange:
      primaryColor = Colors.orange;
      surfaceColor = Colors.orange.shade900;
      break;
    case AppTheme.blue:
      primaryColor = Colors.blue;
      surfaceColor = Colors.blue.shade900;
  }

  return customTheme.copyWith(
      colorScheme: customTheme.colorScheme.copyWith(
        primary: primaryColor,
        surface: surfaceColor,
      ),
      scaffoldBackgroundColor: surfaceColor);
}
