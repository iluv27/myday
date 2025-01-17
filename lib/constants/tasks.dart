class TaskTemplate {
  final String title;
  final DateTime dueDate;
  bool isTaskCompleted;

  TaskTemplate({
    required this.title,
    required this.dueDate,
    this.isTaskCompleted = false,
  });

  factory TaskTemplate.fromJson(Map<String, dynamic> json) {
    return TaskTemplate(
      title: json['title'] as String,
      dueDate: json['due_time'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['due_time'] * 1000)
          : DateTime.parse(json['due_time']),
      isTaskCompleted: json['status'] as bool,
    );
  }
}
