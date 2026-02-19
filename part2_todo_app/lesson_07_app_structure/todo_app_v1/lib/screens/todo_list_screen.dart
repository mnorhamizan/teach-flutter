import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';

/// The main screen that displays the list of todos.
///
/// In this version (v1), we display static sample data.
/// State management will be added in Lesson 8.
class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  /// Sample todos for demonstration.
  /// In Lesson 8, this will become dynamic state.
  List<Todo> get _sampleTodos => [
        Todo(
          id: '1',
          title: 'Learn Dart basics',
          description: 'Variables, functions, and classes',
          isCompleted: true,
        ),
        Todo(
          id: '2',
          title: 'Understand Flutter widgets',
          description: 'StatelessWidget and StatefulWidget',
          isCompleted: true,
        ),
        Todo(
          id: '3',
          title: 'Build a Todo app',
          description: 'Apply everything learned so far',
        ),
        Todo(
          id: '4',
          title: 'Add state management',
        ),
        Todo(
          id: '5',
          title: 'Implement data persistence',
          description: 'Save todos between app sessions',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final todos = _sampleTodos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Show count of incomplete todos
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${todos.where((t) => !t.isCompleted).length} remaining',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: todos.isEmpty ? _buildEmptyState() : _buildTodoList(todos),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Will be implemented in Lesson 8
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add todo - coming in Lesson 8!'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds the empty state when there are no todos.
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
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the list of todos.
  Widget _buildTodoList(List<Todo> todos) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () {
            // Will be implemented in Lesson 8
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Toggle "${todo.title}" - coming in Lesson 8!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          onDelete: () {
            // Will be implemented in Lesson 8
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Delete "${todo.title}" - coming in Lesson 8!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
