import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/i_task_service.dart';
import 'dart:developer';
import 'base.dart';

class TaskService with BaseService implements ITaskService {
  @override
  Future<TaskTemplate> createSingleTask(
      {required String title,
      required DateTime dueDate,
      bool isTaskCompleted = false}) async {
    final task = TaskTemplate(
        title: title, dueDate: dueDate, isTaskCompleted: isTaskCompleted);

    try {
      final response = await request(
        'MJ-Todo',
        requestType: RequestType.post,
        body: task,
      );

      return TaskTemplate.fromJson(response);
    } catch (e) {
      log("Failed to create task: $e");
      rethrow;
    }
  }

  @override
  Future<List<TaskTemplate>> getTasks() async {
    try {
      final response = await request(
        'MJ-Todo',
        requestType: RequestType.get,
      );

      return (response as List)
          .map((json) => TaskTemplate.fromJson(json))
          .toList();
    } catch (e) {
      log("Failed to get task: $e");
      rethrow;
    }
  }

  @override
  Future<TaskTemplate> deleteTasks() async {
    try {
      final response = await request(
        'MJ-Todo',
        requestType: RequestType.delete,
      );

      return TaskTemplate.fromJson(response);
    } catch (e) {
      log("Failed to delete task: $e");
      rethrow;
    }
  }
}
