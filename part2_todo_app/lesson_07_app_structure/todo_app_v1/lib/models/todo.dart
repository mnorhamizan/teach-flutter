/// Represents a single todo item in the app.
///
/// This is the core data model that holds all information about a todo.
class Todo {
  /// Unique identifier for this todo.
  final String id;

  /// The main title/task description.
  final String title;

  /// Optional longer description with more details.
  final String? description;

  /// Whether this todo has been completed.
  bool isCompleted;

  /// When this todo was created.
  final DateTime createdAt;

  /// Creates a new Todo instance.
  ///
  /// [id] and [title] are required.
  /// [description] is optional.
  /// [isCompleted] defaults to false.
  /// [createdAt] defaults to the current time.
  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Toggles the completion status of this todo.
  void toggleComplete() {
    isCompleted = !isCompleted;
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}

/// Generates a unique ID based on the current timestamp.
///
/// For a production app, consider using a UUID package.
String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
