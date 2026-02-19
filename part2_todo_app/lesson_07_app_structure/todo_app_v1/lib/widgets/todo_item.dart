import 'package:flutter/material.dart';
import '../models/todo.dart';

/// A widget that displays a single todo item.
///
/// Shows:
/// - Checkbox for completion status
/// - Title (with strikethrough if completed)
/// - Optional description
/// - Delete button
class TodoItem extends StatelessWidget {
  /// The todo to display.
  final Todo todo;

  /// Called when the checkbox is tapped.
  final VoidCallback? onToggle;

  /// Called when the delete button is tapped.
  final VoidCallback? onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle?.call(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
                todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            color: todo.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: todo.description != null
            ? Text(
                todo.description!,
                style: TextStyle(
                  color: todo.isCompleted ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red.shade300,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
