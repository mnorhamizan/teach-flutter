# Lesson 7: App Structure and Models

This lesson marks the start of building a complete Todo app. You'll learn how to structure a Flutter project, create data models, and display a basic list of items. By the end, you'll have the foundation for a functional app.

## Learning Objectives

By the end of this lesson, you will be able to:
- Organize a Flutter project with a clear folder structure
- Create a model class to represent app data
- Display data in a ListView
- Understand the relationship between models and UI

## Prerequisites

- Completed Lessons 1-6
- Understanding of classes, ListView, and basic widgets

---

## Project Structure

A well-organized project is easier to maintain and extend. Here's the structure we'll use:

```
lib/
├── main.dart              # App entry point
├── models/
│   └── todo.dart          # Data models
├── screens/
│   └── todo_list_screen.dart  # Full-page screens
└── widgets/
    └── todo_item.dart     # Reusable UI components
```

### Why This Structure?

- **models/**: Data classes that represent your app's information
- **screens/**: Full pages/views that users navigate between
- **widgets/**: Smaller, reusable UI components

This separation makes code easier to find, test, and modify. When you need to change how todos look, you edit `widgets/`. When you change what data a todo contains, you edit `models/`.

---

## The Todo Model

A model represents data in your app. It's a plain Dart class with properties and methods.

### Designing the Model

Before coding, think about what information a todo needs:
- A unique identifier (for updates and deletes)
- A title (what needs to be done)
- An optional description (more details)
- Whether it's completed
- When it was created (for sorting)

### Creating the Model

```dart
// lib/models/todo.dart

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
```

Key decisions:
- `id` is `final` because it never changes
- `isCompleted` is not `final` because we toggle it
- `description` is nullable — not every todo needs details
- `createdAt` has a default value

### Generating IDs

For now, we'll use a timestamp-based ID:

```dart
String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
```

In a real app, you might use a UUID package or database-generated IDs.

---

## Building the UI

### The Main Screen

```dart
// lib/screens/todo_list_screen.dart

import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  // Sample data for now
  List<Todo> get _sampleTodos => [
    Todo(id: '1', title: 'Learn Flutter'),
    Todo(id: '2', title: 'Build a Todo app'),
    Todo(id: '3', title: 'Deploy to app store', description: 'iOS and Android'),
  ];

  @override
  Widget build(BuildContext context) {
    final todos = _sampleTodos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
      ),
      body: todos.isEmpty
          ? const Center(child: Text('No todos yet'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoItem(todo: todos[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add todo (implemented in Lesson 8)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### The Todo Item Widget

```dart
// lib/widgets/todo_item.dart

import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          // Toggle (implemented in Lesson 8)
        },
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: todo.description != null
          ? Text(todo.description!)
          : null,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Delete (implemented in Lesson 8)
        },
      ),
    );
  }
}
```

### Wiring It Together

```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}
```

---

## Understanding the Data Flow

Right now, the data flow is simple:

```
Sample Data → ListView → TodoItem widgets
```

Each `TodoItem` receives a `Todo` object and displays it. The checkbox and delete button don't work yet — they'll be implemented in Lesson 8 with state management.

### Why StatelessWidget?

At this stage, `TodoListScreen` is a `StatelessWidget` because the sample data doesn't change. In Lesson 8, we'll convert it to a `StatefulWidget` to handle adding, deleting, and toggling todos.

---

## Empty State

Always handle the case when there's no data:

```dart
body: todos.isEmpty
    ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No todos yet', style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
    : ListView.builder(...),
```

An empty state tells users the app is working — there's just nothing to show.

---

## Common Mistakes

**Putting all code in main.dart:**

Split your code into separate files by responsibility. It's easier to find and modify specific features.

**Forgetting to pass data to widgets:**

```dart
// Wrong — TodoItem doesn't know which todo to display
TodoItem()

// Correct — pass the todo as a parameter
TodoItem(todo: todos[index])
```

**Not planning the model first:**

Think about what data you need before coding the UI. Adding properties later often requires changes throughout the app.

---

## Summary

- Organize code into `models/`, `screens/`, and `widgets/`
- Create model classes to represent app data
- Use ListView.builder to display lists efficiently
- Handle empty states
- Static data now; dynamic state in Lesson 8

---

## Exercises

### Exercise 1: Add a Priority Field

**Objective:** Practice extending the model.

**Instructions:**
1. Add a `priority` field to the Todo model
2. Use an enum: `low`, `medium`, `high`
3. Display priority with a colored icon in TodoItem
4. Add sample todos with different priorities

### Exercise 2: Date Display

**Objective:** Practice formatting dates.

**Instructions:**
1. Display the creation date in TodoItem
2. Format it as "Jan 15, 2024" or similar
3. Show it below the description

### Exercise 3: Card Layout

**Objective:** Practice alternative UI layouts.

**Instructions:**
1. Change TodoItem to use Card instead of ListTile
2. Add more visual styling
3. Include the description and date

### Exercise 4: Grouped List

**Objective:** Practice list organization.

**Instructions:**
1. Group todos by completion status
2. Show "Active" and "Completed" sections
3. Use a header before each section

---

## Next Steps

In Lesson 8, you'll add interactivity with state management. You'll learn to add new todos, toggle completion, and delete items using `setState()`.
