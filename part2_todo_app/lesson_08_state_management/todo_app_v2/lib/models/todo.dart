/// Represents a single todo item in the app.
class Todo {
  final String id;
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  void toggleComplete() {
    isCompleted = !isCompleted;
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}

String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
