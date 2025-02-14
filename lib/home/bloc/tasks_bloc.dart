import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:myday/constants/tasks.dart';
import 'package:myday/home/bloc/tasks_provider.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> with TasksProvider {
  TasksBloc() : super(InitialTasksState()) {
    on<InitTasksEvent>(_onInit);

    on<AddTasksEvent>(_addTaskEvent);

    on<UpdateTasksEvent>((event, emit) async {
      try {
        // final taskIndex =
        //     state.tasks2.indexWhere((task) => task.id == event.id);
        // if (taskIndex == -1) {
        //   emit(ErrorTasksState(error: 'Task not found.'));
        //   return;
        // }

        await updateTask(
          id: event.id,
          isTaskDone: event.isTaskCompleted,
        );

        // // Reorder tasks: Move completed tasks to the bottom
        // task.sort((a, b) {
        //   if (a.isTaskCompleted && !b.isTaskCompleted) return 1;
        //   if (!a.isTaskCompleted && b.isTaskCompleted) return -1;
        //   return 0;
        // });
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });

    on<OptimisticUpdateTasksEvent>((event, emit) async {
      if (state is LoadedTasksState) {
        final updatedTasks = (state as LoadedTasksState).tasks.map((task) {
          if (task.id == event.id) {
            return task.copyWith(
                isTaskCompleted: event.isTaskCompleted,
                id: task.id,
                title: task.title,
                dueDate: task.dueDate);
          }
          return task;
        }).toList();

        emit(LoadedTasksState(tasks: updatedTasks));
      }
    });

    on<DeleteTasksEvent>((event, emit) async {
      try {
        await deleteTask(id: event.id);
        final tasks = await getTasks();

        emit(LoadedTasksState(tasks: tasks));
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });
  }
  Future _onInit(InitTasksEvent event, Emitter<TasksState> emit) async {
    try {
      emit(LoadingTasksState(isLoading: true));

      log('Initialize 1');

      final task = await getTasks();

      log('Initialize 2');

      // // ✅ **Listen for internet connectivity changes**
      // Connectivity().onConnectivityChanged.listen((result) {
      //   if (result as ConnectivityResult != ConnectivityResult.none) {
      //     add(SyncTasksWithApiEvent()); // **Sync with API when online**
      //   }
      // });

      emit(LoadingTasksState());
      log('Initialize 3');
      emit(LoadedTasksState(tasks: task));
      log('Initialize 4');
    } catch (e) {
      log('Initialize 5');
      emit(ErrorTasksState(error: e.toString()));
    }
  }

  Future _addTaskEvent(AddTasksEvent event, Emitter<TasksState> emit) async {
    emit(LoadingTasksState(isLoading: true));

    try {
      await writeTask(
        title: event.task,
        id: TaskTemplate.generateId(),
        dueDate: event.dueDate,
        isTaskDone: event.isTaskCompleted,
      );

      final tasks = await getTasks();
      emit(LoadingTasksState());
      emit(LoadedTasksState(tasks: tasks));
    } catch (e) {
      emit(ErrorTasksState(error: e.toString()));
    }
  }
}
