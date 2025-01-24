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

class CompleteTasksEvent extends TasksEvent {
  final TaskTemplate task;
  CompleteTasksEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class DeleteTasksEvent extends TasksEvent {
  final TaskTemplate taskTemplate;
  DeleteTasksEvent({required this.taskTemplate});
  @override
  List<Object?> get props => [taskTemplate];
}
