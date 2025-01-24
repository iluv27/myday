part of 'tasks_bloc.dart';

@immutable
sealed class TasksState extends Equatable {}

final class InitialTasksState extends TasksState {
  @override
  List<Object?> get props => [];
}

class LoadingTasksState extends TasksState {
  final bool isLoading;

  LoadingTasksState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}

final class LoadedTasksState extends TasksState {
  final List<TaskTemplate> tasks;
  LoadedTasksState({
    required this.tasks,
  });
  @override
  List<Object?> get props => [tasks];
}

final class ErrorTasksState extends TasksState {
  final String error;
  ErrorTasksState({required this.error});
  @override
  List<Object?> get props => [error];
}
