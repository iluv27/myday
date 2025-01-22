import 'dart:developer';

import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/i_task_service.dart';

mixin TasksProvider {
  Future<void> writeTask({
    required String title,
    required DateTime dueDate,
    required bool isTaskDone,
  }) async {
    await ITaskService.instance.createSingleTask(
      title: title,
      dueDate: dueDate,
      isTaskCompleted: isTaskDone,
    );
  }

  Future<List<TaskTemplate>> getTasks() async {
    try {
      return await ITaskService.instance.getTasks();
    } catch (e) {
      log('Error fetching tasks: $e');
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> updateTask({
    required String title,
    required DateTime dueDate,
    required bool isTaskDone,
  }) async {
    await ITaskService.instance.updateTask(
      title: title,
      dueDate: dueDate,
      isTaskCompleted: isTaskDone,
    );
  }

  Future deleteTask() async {
    return await ITaskService.instance.deleteTasks();
  }
}
