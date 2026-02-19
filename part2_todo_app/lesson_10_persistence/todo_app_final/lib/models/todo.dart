/// Represents a single todo item in the app.
class Todo {
  final String id;
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime createdAt;
  final Priority priority;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.priority = Priority.medium,
  }) : createdAt = createdAt ?? DateTime.now();

  void toggleComplete() {
    isCompleted = !isCompleted;
  }

  /// Creates a Todo from a JSON map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      priority: Priority.values.firstWhere(
        (p) => p.name == json['priority'],
        orElse: () => Priority.medium,
      ),
    );
  }

  /// Converts the Todo to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'priority': priority.name,
    };
  }

  /// Creates a copy of the todo with optional updated values.
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    Priority? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, priority: $priority, isCompleted: $isCompleted)';
  }
}

/// Priority levels for todos.
enum Priority {
  low,
  medium,
  high;

  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}

String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
