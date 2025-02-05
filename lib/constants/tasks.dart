import 'package:uuid/uuid.dart';

class TaskTemplate {
  final String? id;
  final String? title;
  final DateTime? dueDate;
  bool isTaskCompleted;

  TaskTemplate({
    this.id,
    this.title,
    this.dueDate,
    this.isTaskCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'due_time': dueDate?.millisecondsSinceEpoch,
      'status': isTaskCompleted,
    };
  }

  factory TaskTemplate.fromJson(Map<String, dynamic> json) {
    return TaskTemplate(
      id: json['id'] as String,
      title: json['title'] as String,
      dueDate: json['due_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['due_time'])
          : null, // Convert timestamp to DateTime
      isTaskCompleted: json['status'] as bool,
    );
  }

  TaskTemplate copyWith({
    required bool isTaskCompleted,
    final String? id,
    final String? title,
    final DateTime? dueDate,
  }) {
    return TaskTemplate(
      id: id,
      title: title,
      dueDate: dueDate,
      isTaskCompleted: isTaskCompleted,
    );
  }

  static String generateId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
