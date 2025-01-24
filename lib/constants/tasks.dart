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
      'due_time': dueDate is int
          ? DateTime.fromMillisecondsSinceEpoch(dueDate as int)
          : DateTime.parse(dueDate as String),
      'status': isTaskCompleted,
    };
  }

  factory TaskTemplate.fromJson(Map<String, dynamic> json) {
    return TaskTemplate(
      id: json['id'] as String,
      title: json['title'] as String,
      dueDate: json['due_time'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['due_time'] * 1000)
          : DateTime.parse(json['due_time']),
      isTaskCompleted: json['status'] as bool,
    );
  }
}
