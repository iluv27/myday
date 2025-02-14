import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/home/home.dart';
import 'package:myday/theme/bloc/theme_bloc.dart';
import 'package:myday/theme/theme_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => TasksBloc()..add(InitTasksEvent()),
      ),
      BlocProvider(
        create: (context) => ThemeBloc()..add(InitThemeEvent()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadedState) {
          return MaterialApp(
            theme: buildTheme(state.theme),
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        }
        return MaterialApp(
          theme: buildTheme(AppTheme.blue),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
