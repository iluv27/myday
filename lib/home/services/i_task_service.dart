import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/task_service.dart';

abstract class ITaskService {
  static final ITaskService _instance = TaskService();

  static ITaskService get instance => _instance;
  Future<TaskTemplate> createSingleTask({
    required String title,
    required DateTime dueDate,
    bool isTaskCompleted = false,
  }) {
    throw UnimplementedError('task unable to be created');
  }

  Future<List<TaskTemplate>> getTasks() async {
    try {
      final tasks = await getTasks();
      return tasks;
      // ignore: empty_catches
    } catch (e) {}

    // Replace with actual logic
    throw UnimplementedError('task could not be gotten from the backend');
  }

  Future<TaskTemplate> updateTask({
    required String title,
    required DateTime dueDate,
    bool isTaskCompleted = false,
  }) {
    throw UnimplementedError('task unable to be created');
  }

  Future<TaskTemplate> deleteTasks() {
    throw UnimplementedError('task could not be deleted');
  }
}
