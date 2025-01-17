import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:myday/constants/tasks.dart';
import 'package:myday/home/bloc/tasks_provider.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

enum TasksCreated {
  tasksPage,
  createTasksPage,
}

class TasksBloc extends Bloc<TasksEvent, TasksState> with TasksProvider {
  TasksBloc() : super(InitialTasksState()) {
    // ignore: unused_local_variable
    TasksCreated tasksCreated = TasksCreated.tasksPage;

    on<InitTasksEvent>((event, emit) async {
      tasksCreated = TasksCreated.tasksPage;
      try {
        final tasks = await getTasks();

        emit(LoadedTasksState(tasks: tasks));
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });

    on<AddTasksEvent>((event, emit) async {
      try {
        await writeTask(
          title: event.task,
          dueDate: event.dueDate,
          isTaskDone: event.isTaskCompleted,
        );
        final tasks = await getTasks();
        emit(LoadedTasksState(tasks: tasks));
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }

      tasksCreated = TasksCreated.tasksPage;
    });

    on<CompleteTasksEvent>((event, emit) async {
      final tasks = await getTasks();

      emit(LoadedTasksState(tasks: tasks));
    });

    on<DeleteTasksEvent>((event, emit) async {
      try {
        await deleteTask();
        final tasks = await getTasks();
        tasks.remove(event.taskTemplate);
        emit(LoadedTasksState(tasks: tasks));
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });
  }
}
