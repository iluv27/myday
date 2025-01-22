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

    on<UpdateTasksEvent>(_updateTaskEvent);

    on<CompleteTasksEvent>((event, emit) async {
      try {
        emit(LoadingTasksState(isLoading: true));

        final task = await getTasks();
        emit(LoadedTasksState(
          tasks: task,
        ));
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });

    on<DeleteTasksEvent>((event, emit) async {
      try {
        await deleteTask();
        final tasks = await getTasks();
        tasks.remove(event.taskTemplate);
      } catch (e) {
        emit(ErrorTasksState(error: e.toString()));
      }
    });
  }

  List<TaskTemplate> _tasks = [];
  List<TaskTemplate> get tasks => _tasks;

  Future _onInit(InitTasksEvent event, Emitter<TasksState> emit) async {
    try {
      emit(LoadingTasksState(isLoading: true)); // Emit loading state

      _tasks = await getTasks(); // Fetch tasks from provider

      emit(LoadedTasksState(tasks: tasks)); // Emit loaded state
    } catch (e) {
      emit(ErrorTasksState(error: e.toString())); // Emit error state
    }
  }

  Future _addTaskEvent(AddTasksEvent event, Emitter<TasksState> emit) async {
    try {
      await writeTask(
        title: event.task,
        dueDate: event.dueDate,
        isTaskDone: event.isTaskCompleted,
      );
      emit(LoadingTasksState(isLoading: true));
      _tasks = await getTasks();
      emit(LoadedTasksState(tasks: tasks));
    } catch (e) {
      emit(ErrorTasksState(error: e.toString()));
    }
  }

  Future _updateTaskEvent(
      UpdateTasksEvent event, Emitter<TasksState> emit) async {
    try {
      await updateTask(
        title: event.task.title,
        dueDate: event.task.dueDate,
        isTaskDone: event.isTaskCompleted,
      );
      emit(LoadingTasksState(isLoading: true));
      _tasks = await getTasks();
      emit(LoadedTasksState(
        tasks: tasks,
      ));
    } catch (e) {
      emit(ErrorTasksState(error: e.toString()));
    }
  }
}
