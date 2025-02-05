import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/home/home.dart';
import 'package:myday/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  runApp(BlocProvider(
    create: (context) => TasksBloc()..add(InitTasksEvent()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
