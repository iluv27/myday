part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitThemeEvent extends ThemeEvent {}

class UpdateThemeEvent extends ThemeEvent {
  final AppTheme appTheme;

  UpdateThemeEvent({required this.appTheme});

  @override
  List<Object> get props => [appTheme];
}
