/// Represents a single todo item in the app.
class Todo {
  final int? id;
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Priority priority;

  Todo({
    this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.updatedAt,
    this.priority = Priority.medium,
  }) : createdAt = createdAt ?? DateTime.now();

  void toggleComplete() {
    isCompleted = !isCompleted;
  }

  /// Creates a Todo from the API's JSON response.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      priority: PriorityExtension.fromInt(json['priority'] as int),
    );
  }

  /// Converts the Todo to JSON for the API (create request).
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority.toInt(),
    };
  }

  /// Converts the Todo to JSON for the API (update request).
  Map<String, dynamic> toUpdateJson() {
    return {
      'title': title,
      'description': description,
      'completed': isCompleted,
      'priority': priority.toInt(),
    };
  }

  /// Creates a copy of the todo with optional updated values.
  Todo copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Priority? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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

  /// Converts to API integer format: 1=Low, 2=Medium, 3=High.
  int toInt() {
    switch (this) {
      case Priority.low:
        return 1;
      case Priority.medium:
        return 2;
      case Priority.high:
        return 3;
    }
  }
}

/// Extension to create Priority from API integer.
extension PriorityExtension on Priority {
  static Priority fromInt(int value) {
    switch (value) {
      case 1:
        return Priority.low;
      case 3:
        return Priority.high;
      default:
        return Priority.medium;
    }
  }
}
