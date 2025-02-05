import 'dart:developer';

import 'package:myday/constants/tasks.dart';
import 'package:myday/home/services/i_task_service.dart';

mixin TasksProvider {
  Future<void> writeTask({
    required String title,
    required String id,
    required DateTime dueDate,
    required bool isTaskDone,
  }) async {
    await ITaskService.instance.createSingleTask(
      title: title,
      id: id,
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

  Future<TaskTemplate> updateTask({
    String? id,
    required bool isTaskDone,
  }) async {
    final updated = await ITaskService.instance.updateTask(
      id: id,
      isTaskCompleted: isTaskDone,
    );
    return updated;
  }

  Future deleteTask({String? id}) async {
    return await ITaskService.instance.deleteTasks(id: id);
  }
}
