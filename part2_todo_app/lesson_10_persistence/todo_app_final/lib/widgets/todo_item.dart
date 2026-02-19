import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TodoItem({
    super.key,
    required this.todo,
    this.onToggle,
    this.onDelete,
    this.onTap,
  });

  Color _getPriorityColor() {
    switch (todo.priority) {
      case Priority.high:
        return Colors.red.shade100;
      case Priority.medium:
        return Colors.orange.shade100;
      case Priority.low:
        return Colors.green.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description != null)
              Text(
                todo.description!,
                style: TextStyle(
                  color: todo.isCompleted ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getPriorityColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                todo.priority.label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red.shade300,
          onPressed: onDelete,
        ),
      ),
    );
  }
}
