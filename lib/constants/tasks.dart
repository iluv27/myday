class TaskTemplate {
  final String title;
  final DateTime dueDate;
  bool isTaskCompleted;

  TaskTemplate({
    required this.title,
    required this.dueDate,
    required this.isTaskCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'due_time': dueDate.millisecondsSinceEpoch,
      'status': isTaskCompleted,
    };
  }

  factory TaskTemplate.fromJson(Map<String, dynamic> json) {
    return TaskTemplate(
      title: json['title'] as String,
      dueDate: json['due_time'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['due_time'] * 1000)
          : DateTime.parse(json['due_time']),
      isTaskCompleted: json['status'] as bool,
    );
  }

  Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
}
