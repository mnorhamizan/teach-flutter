# Lesson 10: Data Persistence

Your todo app works great, but there's one problem: when you close and reopen it, all your todos disappear. This lesson covers saving data locally using SharedPreferences.

## Learning Objectives

By the end of this lesson, you will be able to:
- Save data locally with SharedPreferences
- Convert objects to JSON for storage
- Load saved data when the app starts
- Handle asynchronous initialization

## Prerequisites

- Completed Lesson 9 (Forms and Validation)
- Understanding of async/await from earlier lessons

---

## Why Persistence?

Mobile apps need to remember data between sessions. Options include:

| Storage Type | Best For | Example |
|-------------|----------|---------|
| SharedPreferences | Small, simple data | Settings, user preferences, small lists |
| SQLite | Structured, relational data | Complex apps with many related records |
| File storage | Large files, documents | Images, PDFs, exports |
| Cloud storage | Multi-device sync | Firebase, custom backends |

For our todo list, SharedPreferences is sufficient and straightforward.

---

## Adding SharedPreferences

First, add the package to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

Then run:

```bash
flutter pub get
```

---

## Converting Todos to JSON

SharedPreferences stores simple types: strings, integers, booleans, and lists of strings. To store our Todo objects, we convert them to JSON strings.

Add these methods to your Todo model:

```dart
class Todo {
  final String id;
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime createdAt;
  final Priority priority;

  // ... existing constructor ...

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
}
```

The `toJson()` method converts a Todo object to a Map that can be serialized. The `fromJson()` factory constructor recreates the object from that Map.

---

## Creating a Storage Service

Encapsulate storage logic in a dedicated service:

```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class StorageService {
  static const String _todosKey = 'todos';

  /// Saves the list of todos to SharedPreferences.
  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert todos to a list of JSON strings
    final jsonList = todos.map((todo) => jsonEncode(todo.toJson())).toList();

    await prefs.setStringList(_todosKey, jsonList);
  }

  /// Loads todos from SharedPreferences.
  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_todosKey);

    if (jsonList == null || jsonList.isEmpty) {
      return [];
    }

    return jsonList
        .map((jsonStr) => Todo.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  /// Clears all saved todos.
  Future<void> clearTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_todosKey);
  }
}
```

---

## Loading Data on Startup

The tricky part is loading data before the UI renders. There are several approaches:

### Approach 1: Load in initState with setState

```dart
class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final StorageService _storage = StorageService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _storage.loadTodos();
    setState(() {
      _todos.addAll(todos);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    // ... rest of build
  }
}
```

### Approach 2: FutureBuilder

```dart
class TodoListScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: StorageService().loadTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final todos = snapshot.data ?? [];
        return _buildTodoList(todos);
      },
    );
  }
}
```

Approach 1 is often simpler for mutable state that needs to be modified after loading.

---

## Saving Changes

Save whenever the todo list changes:

```dart
void _addTodo(Todo todo) {
  setState(() {
    _todos.add(todo);
  });
  _storage.saveTodos(_todos);  // Save after update
}

void _toggleTodo(String id) {
  setState(() {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.toggleComplete();
  });
  _storage.saveTodos(_todos);  // Save after update
}

void _deleteTodo(String id) {
  setState(() {
    _todos.removeWhere((t) => t.id == id);
  });
  _storage.saveTodos(_todos);  // Save after update
}
```

You could also debounce saves or batch them, but for a small todo list, saving immediately is fine.

---

## Error Handling

Add error handling for storage operations:

```dart
Future<void> _loadTodos() async {
  try {
    final todos = await _storage.loadTodos();
    setState(() {
      _todos.addAll(todos);
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load todos')),
      );
    }
  }
}

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
```

---

## Understanding JSON Encoding

The `dart:convert` library provides `jsonEncode` and `jsonDecode`:

```dart
import 'dart:convert';

// Object -> JSON string
final map = {'name': 'John', 'age': 30};
final jsonString = jsonEncode(map);  // '{"name":"John","age":30}'

// JSON string -> Object
final decoded = jsonDecode(jsonString);  // {name: John, age: 30}
```

For lists of objects:

```dart
// List<Todo> -> List<String> for SharedPreferences
final jsonList = todos.map((t) => jsonEncode(t.toJson())).toList();

// List<String> -> List<Todo>
final todos = jsonList.map((s) => Todo.fromJson(jsonDecode(s))).toList();
```

---

## Common Mistakes

**Forgetting to await async operations:**

```dart
// Wrong - doesn't wait for save to complete
void _addTodo(Todo todo) {
  _todos.add(todo);
  _storage.saveTodos(_todos);  // Fire and forget
}

// Better - handles errors properly
Future<void> _addTodo(Todo todo) async {
  _todos.add(todo);
  try {
    await _storage.saveTodos(_todos);
  } catch (e) {
    // Handle error
  }
}
```

**Not showing loading state:**

```dart
// Wrong - user sees empty list briefly
@override
void initState() {
  super.initState();
  _loadTodos();  // Async, UI builds before data loads
}

// Correct - show loading indicator
bool _isLoading = true;

@override
Widget build(BuildContext context) {
  if (_isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  // ...
}
```

**Calling setState after dispose:**

```dart
Future<void> _loadTodos() async {
  final todos = await _storage.loadTodos();
  if (mounted) {  // Check if widget is still mounted
    setState(() {
      _todos.addAll(todos);
    });
  }
}
```

---

## Summary

- SharedPreferences stores simple data types locally
- Convert objects to JSON with `toJson()` and `fromJson()`
- Use `dart:convert` for JSON encoding/decoding
- Load data in `initState` and show loading state
- Save whenever data changes
- Handle errors and check `mounted` before `setState`

---

## Exercises

### Exercise 1: Sort Preference

**Objective:** Remember the user's preferred sort order.

**Instructions:**
1. Add a sort dropdown (by date, priority, alphabetical)
2. Save the selected sort option to SharedPreferences
3. Load and apply it when the app starts

### Exercise 2: Theme Preference

**Objective:** Allow dark/light mode toggle that persists.

**Instructions:**
1. Add a theme toggle in the app bar
2. Save the theme preference to SharedPreferences
3. Load and apply the theme on app start

### Exercise 3: Export/Import

**Objective:** Allow users to backup and restore todos.

**Instructions:**
1. Add an export button that copies all todos as JSON to clipboard
2. Add an import button that parses JSON from clipboard
3. Validate the imported data before adding

---

## Course Complete!

Congratulations on completing the Flutter fundamentals course! You've built a fully functional todo app with:

- Clean project structure
- State management
- Forms and validation
- Local data persistence

### Next Steps

To continue your Flutter journey:

1. **State Management Libraries** - Explore Provider, Riverpod, or BLoC for larger apps
2. **HTTP and APIs** - Learn to fetch data from web services
3. **Firebase** - Add cloud sync, authentication, and more
4. **Testing** - Write unit tests, widget tests, and integration tests
5. **Publishing** - Deploy your app to the App Store and Play Store

### Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/language)
- [Flutter Community on Discord](https://discord.gg/flutter)
