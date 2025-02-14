part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ThemeInitialState extends ThemeState {
  ThemeInitialState();
}

final class ThemeLoadedState extends ThemeState {
  final AppTheme theme;
  ThemeLoadedState({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}

// class ThemeLoadingState extends ThemeState {
//   final bool isLoading;

//   const ThemeLoadingState({this.isLoading = false});

//   @override
//   List<Object> get props => [isLoading];
// }
