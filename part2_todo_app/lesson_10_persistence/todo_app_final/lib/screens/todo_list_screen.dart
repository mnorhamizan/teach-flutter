import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/storage_service.dart';
import '../widgets/todo_item.dart';
import 'todo_form_screen.dart';

/// The main screen that displays and manages the list of todos.
///
/// This final version adds:
/// - Loading todos from storage on startup
/// - Saving todos to storage on every change
/// - Loading indicator while data loads
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  /// The list of todos - this is the app's state.
  final List<Todo> _todos = [];

  /// Storage service for persistence.
  final StorageService _storage = StorageService();

  /// Whether the app is loading data.
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  /// Loads todos from storage.
  Future<void> _loadTodos() async {
    try {
      final todos = await _storage.loadTodos();
      if (mounted) {
        setState(() {
          _todos.addAll(todos);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load todos')),
        );
      }
    }
  }

  /// Saves todos to storage.
  Future<void> _saveTodos() async {
    try {
      await _storage.saveTodos(_todos);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save')),
        );
      }
    }
  }

  /// Navigates to the form screen to add a new todo.
  void _addTodo() async {
    final newTodo = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(
        builder: (context) => const TodoFormScreen(),
      ),
    );

    if (newTodo != null) {
      setState(() {
        _todos.add(newTodo);
      });
      _saveTodos();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todo added!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  /// Navigates to the form screen to edit an existing todo.
  void _editTodo(Todo todo) async {
    final updatedTodo = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(
        builder: (context) => TodoFormScreen(existingTodo: todo),
      ),
    );

    if (updatedTodo != null) {
      setState(() {
        final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
        if (index != -1) {
          _todos[index] = updatedTodo;
        }
      });
      _saveTodos();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todo updated!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  /// Toggles the completion status of a todo.
  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.toggleComplete();
    });
    _saveTodos();
  }

  /// Deletes a todo with confirmation dialog.
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
              _saveTodos();
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
                      _saveTodos();
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
          if (!_isLoading && _todos.isNotEmpty)
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _todos.isEmpty
              ? _buildEmptyState()
              : _buildTodoList(),
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
          onTap: () => _editTodo(todo),
        );
      },
    );
  }
}
