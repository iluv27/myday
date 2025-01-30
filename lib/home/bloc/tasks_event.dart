part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitTasksEvent extends TasksEvent {}

class AddTasksEvent extends TasksEvent {
  final String task;
  final DateTime dueDate;
  final bool isTaskCompleted;
  AddTasksEvent(
      {required this.dueDate,
      required this.task,
      this.isTaskCompleted = false});

  @override
  List<Object?> get props => [dueDate, task, isTaskCompleted];
}

class UpdateTasksEvent extends TasksEvent {
  final String id;
  final bool isTaskCompleted;
  UpdateTasksEvent({required this.id, this.isTaskCompleted = false});

  @override
  List<Object?> get props => [id, isTaskCompleted];
}

class OptimisticUpdateTasksEvent extends TasksEvent {
  final String id;
  final bool isTaskCompleted;

  OptimisticUpdateTasksEvent({required this.id, required this.isTaskCompleted});
}

class DeleteTasksEvent extends TasksEvent {
  final String id;
  DeleteTasksEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
