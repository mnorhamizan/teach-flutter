import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';

/// The main screen that displays and manages the list of todos.
///
/// This version (v2) adds state management with:
/// - Adding new todos
/// - Toggling completion status
/// - Deleting todos
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  /// The list of todos - this is the app's state.
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    // Start with some sample todos
    _todos.addAll([
      Todo(
        id: generateId(),
        title: 'Learn Flutter state management',
        isCompleted: true,
      ),
      Todo(
        id: generateId(),
        title: 'Build interactive features',
        description: 'Add, delete, and toggle todos',
      ),
      Todo(
        id: generateId(),
        title: 'Explore more Flutter features',
      ),
    ]);
  }

  /// Shows a dialog to add a new todo.
  void _addTodo() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'What needs to be done?',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => _submitTodo(controller.text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _submitTodo(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Submits a new todo with the given title.
  void _submitTodo(String title) {
    if (title.trim().isEmpty) return;

    setState(() {
      _todos.add(Todo(
        id: generateId(),
        title: title.trim(),
      ));
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todo added!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// Toggles the completion status of a todo.
  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.toggleComplete();
    });
  }

  /// Deletes a todo, optionally showing a confirmation dialog.
  void _deleteTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Todo'),
        content: Text('Delete "${todo.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _todos.removeWhere((t) => t.id == id);
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${todo.title}" deleted'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        _todos.add(todo);
                      });
                    },
                  ),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Returns the count of incomplete todos.
  int get _remainingCount => _todos.where((t) => !t.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_todos.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '$_remainingCount remaining',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      body: _todos.isEmpty ? _buildEmptyState() : _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No todos yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first todo',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => _toggleTodo(todo.id),
          onDelete: () => _deleteTodo(todo.id),
        );
      },
    );
  }
}
