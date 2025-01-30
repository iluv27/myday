import 'dart:convert';

import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/i_task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'base.dart';

class TaskService with BaseService implements ITaskService {
  final String apiUrl = 'MJ-Todo';
  final String _tasksCacheKey = 'tasks_cache_key';

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
        body: task.toJson(),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_tasksCacheKey, jsonEncode(response));

      return TaskTemplate.fromJson(response);
    } catch (e) {
      log("Failed to create task: $e");
      rethrow;
    }
  }

  @override
  Future<List<TaskTemplate>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await request(
        apiUrl,
        requestType: RequestType.get,
      );

      //  final prefs = await SharedPreferences.getInstance();

      // // First, check if cached data exists
      // final cachedTasks = prefs.getString(_tasksCacheKey);

      // Save to cache
      prefs.setString(_tasksCacheKey, jsonEncode(response));

      return (response as List)
          .map((json) => TaskTemplate.fromJson(json))
          .toList();
    } catch (e) {
      final cachedData = prefs.getString(_tasksCacheKey);
      if (cachedData != null) {
        return (cachedData as List)
            .map((json) => TaskTemplate.fromJson(json))
            .toList();
      }
      log("Failed to get task: $e");
      rethrow;
    }
  }

  @override
  Future<TaskTemplate> updateTask(
      {String? id, required bool isTaskCompleted}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$_tasksCacheKey $id', isTaskCompleted.toString());
    prefs.reload();
    log('UPDATE 1');
    try {
      log('UPDATE 2');
      final response = await request(
        'MJ-Todo/$id', // Assuming `taskId` is part of the endpoint
        requestType: RequestType.patch,
        body: {
          'status': isTaskCompleted, // Only update this field
        },
      );

      log('UPDATE 3');

      return TaskTemplate.fromJson(response);
    } catch (e) {
      log('UPDATE 4');
      log("Failed to update task: $e");
      rethrow;
    }
  }

  // @override
  // Future<TaskTemplate> getTaskPreference(TaskTemplate task) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tasksCacheKey) as TaskTemplate;
  // }

  @override
  Future<TaskTemplate> deleteTasks() async {
    try {
      final response = await request(
        'MJ-Todo',
        requestType: RequestType.delete,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tasksCacheKey);

      return TaskTemplate.fromJson(response);
    } catch (e) {
      log("Failed to delete task: $e");
      rethrow;
    }
  }
}
