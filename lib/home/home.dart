import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/home/create_task.dart';
import 'package:myday/theme/bloc/theme_bloc.dart';
import 'package:myday/theme/theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _listener(BuildContext context, TasksState state) {
    // if (state is LoadingTasksState) {
    //   //Error state
    //   if (state is ErrorTasksState) {
    //     AppToast.show('Error in creating tasks. Please try again', error: true);
    //   }
    //   //Success state
    //   if (state is LoadedTasksState) {
    //     AppToast.show('Tasks created successfully');
    //   }
    // }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else if (hour >= 17 && hour < 20) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }

  String _getGreetingSalutes() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'What are we doing today?';
    } else if (hour >= 12 && hour < 17) {
      return 'What are we doing today?';
    } else if (hour >= 17 && hour < 20) {
      return 'What are we doing tonight?';
    } else {
      return 'What are we doing tonight?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: _listener,
        builder: (context, state) {
          final bloc = context.read<TasksBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'image/logo.png',
                scale: 4.5,
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    final themeState = context.read<ThemeBloc>().state;

                    if (themeState is ThemeLoadedState) {
                      // Get the current theme index
                      final currentThemeIndex =
                          AppTheme.values.indexOf(themeState.theme);

                      // Get the next theme index
                      final nextThemeIndex =
                          (currentThemeIndex + 1) % AppTheme.values.length;

                      // Get the next theme
                      final nextTheme = AppTheme.values[nextThemeIndex];

                      // Dispatch theme update event
                      context
                          .read<ThemeBloc>()
                          .add(UpdateThemeEvent(appTheme: nextTheme));
                    }
                  },
                  icon: Icon(Icons.change_circle_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notification_important_rounded),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _getGreeting(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _getGreetingSalutes(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (state is LoadingTasksState)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state is LoadedTasksState)
                    state.tasks.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 120.0),
                            child: Container(
                              padding: EdgeInsets.all(60),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Write all your tasks for the day. Check them as you go!!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 2),
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: state.tasks.length,
                              itemBuilder: (context, index) {
                                final task = state.tasks[index];
                                final formattedDueDate =
                                    "${task.dueDate!.hour}:${task.dueDate!.minute < 10 ? '0' : ''}${task.dueDate!.minute} ${task.dueDate!.hour < 12 ? 'AM' : 'PM'}";

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Slidable(
                                    key: ValueKey(task),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        bloc.add(DeleteTasksEvent(
                                            id: task.id.toString()));
                                      }),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            bloc.add(DeleteTasksEvent(
                                                id: task.id.toString()));
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: CheckboxListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      tileColor: AppColors.bgDark,
                                      title: Text(
                                        task.title.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      subtitle: Text(
                                        formattedDueDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      checkboxScaleFactor: 1.6,
                                      checkboxShape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: task.isTaskCompleted
                                                ? AppColors.primary
                                                : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: task.isTaskCompleted,
                                      selected: task.isTaskCompleted,
                                      secondary: Icon(
                                        size: 30,
                                        task.isTaskCompleted
                                            ? Icons
                                                .sentiment_very_satisfied_rounded
                                            : Icons.sentiment_neutral_rounded,
                                        color: task.isTaskCompleted
                                            ? AppColors.primary
                                            : Colors.grey,
                                      ),
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          // Optimistically update UI first
                                          bloc.add(OptimisticUpdateTasksEvent(
                                            id: task.id!,
                                            isTaskCompleted: value,
                                          ));

                                          bloc.add(UpdateTasksEvent(
                                            id: task
                                                .id!, // Ensure you're using the unique ID
                                            isTaskCompleted: value,
                                          ));
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateTask();
                }));
              },
              tooltip: 'Increment',
              child: const Icon(
                Icons.add,
                color: Color(0xFF330648),
              ),
            ),
          );
        },
      ),
    );
  }
}
