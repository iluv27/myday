import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myday/home/bloc/tasks_bloc.dart';
import 'package:myday/home/create_task.dart';
import 'package:myday/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final bool taskDone = false;

  @override
  Widget build(BuildContext context) {
    context.read<TasksBloc>().add(InitTasksEvent());

    return SafeArea(
      child: BlocConsumer<TasksBloc, TasksState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Icon(
                Icons.menu_rounded,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Hello!!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'What are we doing today?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (state is LoadedTasksState)
                    state.tasks.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(30),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 88, 158, 255)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                'Write all your tasks for the day. Check them as you go!!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
                                    "${task.dueDate.hour}:${task.dueDate.minute < 10 ? '0' : ''}${task.dueDate.minute} ${task.dueDate.hour < 12 ? 'AM' : 'PM'}";

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: CheckboxListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      tileColor: AppColors.bgDark,
                                      title: Text(
                                        task.title,
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: task.isTaskCompleted,
                                      selected: task.isTaskCompleted,
                                      secondary: Icon(
                                        Icons.emoji_emotions_rounded,
                                        color: Colors.grey,
                                      ),
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          // Update task completion status through Bloc
                                          context.read<TasksBloc>().add(
                                                CompleteTasksEvent(task: task),
                                              );
                                        }
                                      }),
                                );
                              },
                            ),
                          ),
                  if (state is LoadingTasksState)
                    Center(
                      child: CircularProgressIndicator(),
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
