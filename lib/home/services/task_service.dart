import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/i_task_service.dart';
import 'package:myday/theme/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class TaskService implements ITaskService {
  final String _tasksCacheKey = 'tasks_cache_key';

  Future<List<TaskTemplate>> _loadTasksFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getStringList(_tasksCacheKey);
      log("THIS IS CACHED DATA: $cachedData");
      if (cachedData == null || cachedData.isEmpty) {
        return [];
      } else {
        return cachedData
            .map((json) => TaskTemplate.fromJson(jsonDecode(json)))
            .toList();
      }
    } catch (e) {
      log("Error fetching tasks from cache: $e");
      return [];
    }
  }

  Future<void> _saveTasksToCache(List<TaskTemplate> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      log("THIS IS PREFS: $prefs");
      final encodedTasks =
          tasks.map((todo) => jsonEncode(todo.toJson())).toList();

      log("THIS IS ENCODED TASKS: $encodedTasks");
      await prefs.setStringList(_tasksCacheKey, encodedTasks);
    } catch (e) {
      log("Error saving tasks to cache: $e");
    }
  }

  @override
  Future<TaskTemplate> createSingleTask(
      {required String title,
      required String id,
      required DateTime dueDate,
      bool isTaskCompleted = false}) async {
    try {
      final tasks = await _loadTasksFromCache();
      final task = TaskTemplate(
          title: title,
          id: id,
          dueDate: dueDate,
          isTaskCompleted: isTaskCompleted);
      tasks.add(task);
      await _saveTasksToCache(tasks);
      return task;
    } catch (e) {
      log("Failed to create task: $e");
      rethrow;
    }
  }

  @override
  Future<List<TaskTemplate>> getTasks() async {
    try {
      return await _loadTasksFromCache();
    } catch (e) {
      log("Failed to get task: $e");

      rethrow;
    }
  }

  @override
  Future<TaskTemplate> updateTask(
      {String? id, required bool isTaskCompleted}) async {
    final tasks = await _loadTasksFromCache();

    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = TaskTemplate(
        id: tasks[index].id,
        title: tasks[index].title,
        dueDate: tasks[index].dueDate,
        isTaskCompleted: isTaskCompleted,
      );
      await _saveTasksToCache(tasks);
      return tasks[index];
    }
    throw Exception('Update Task Error: Task not found');
  }

  @override
  Future<TaskTemplate> deleteTasks({String? id}) async {
    final tasks = await _loadTasksFromCache();
    final filteredTasks = tasks.where((task) => task.id != id).toList();
    await _saveTasksToCache(filteredTasks);
    return tasks.firstWhere((task) => task.id == id,
        orElse: () =>
            throw Exception('Delete Error: Task could not be deleted.'));
  }
}
