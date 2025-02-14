import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

enum AppTheme {
  blue,
  red,
  green,
  purple,
  orange,
}

final String _themePreferenceKey = 'themeIndex';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitialState()) {
    on<InitThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themePreferenceKey) ?? 0;
      final initialTheme = AppTheme.values[themeIndex];

      emit(ThemeLoadedState(theme: initialTheme));
    });

    // Update the theme on the UpdateThemeEvent
    on<UpdateThemeEvent>((event, emit) async {
      try {
        final nextTheme = event.appTheme;

        emit(ThemeLoadedState(theme: nextTheme));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('themeIndex', nextTheme.index);
        log('Saved theme index: ${nextTheme.index}');
      } catch (e) {
        rethrow;
      }
    });
  }
}
