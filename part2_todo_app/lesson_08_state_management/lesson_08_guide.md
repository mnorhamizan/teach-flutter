# Lesson 8: State Management with setState

Now that you have the app structure, it's time to make it interactive. This lesson covers Flutter's built-in state management using `StatefulWidget` and `setState()`. You'll add the ability to add, delete, and toggle todos.

## Learning Objectives

By the end of this lesson, you will be able to:
- Convert StatelessWidget to StatefulWidget
- Use setState() to update the UI
- Add items to a list dynamically
- Delete items with confirmation
- Toggle item completion status

## Prerequisites

- Completed Lesson 7 (App Structure)
- Understanding of StatefulWidget basics from Lesson 5

---

## Understanding State

**State** is data that can change during the lifetime of a widget. In our Todo app:
- The list of todos is state (it changes when we add/delete)
- Each todo's completion status is state (it changes when toggled)

### When Does UI Update?

Flutter only rebuilds widgets when you tell it something changed. That's what `setState()` does:

```dart
setState(() {
  // Change some state
  _todos.add(newTodo);
});
// Flutter rebuilds the widget
```

Without `setState()`, the data changes but the UI doesn't update.

---

## Converting to StatefulWidget

Transform the TodoListScreen from Lesson 7:

```dart
// Before: StatelessWidget
class TodoListScreen extends StatelessWidget {
  // Sample data - can't change
  List<Todo> get _sampleTodos => [...];
}

// After: StatefulWidget
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // State - can change
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    _todos.addAll([
      Todo(id: '1', title: 'Learn Flutter'),
      Todo(id: '2', title: 'Build a Todo app'),
    ]);
  }
}
```

---

## Adding Todos

### The Add Flow

1. User taps the FAB (Floating Action Button)
2. A dialog appears to enter the todo title
3. User submits
4. We create a new Todo and add it to the list
5. `setState()` triggers a rebuild
6. The new todo appears in the list

### Implementation

```dart
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
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              setState(() {
                _todos.add(Todo(
                  id: generateId(),
                  title: controller.text,
                ));
              });
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}
```

### Connecting to the FAB

```dart
floatingActionButton: FloatingActionButton(
  onPressed: _addTodo,
  child: const Icon(Icons.add),
),
```

---

## Toggling Completion

When the checkbox is tapped, toggle the todo's completion status:

```dart
void _toggleTodo(String id) {
  setState(() {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.toggleComplete();
  });
}
```

Pass this to the TodoItem widget:

```dart
TodoItem(
  todo: todo,
  onToggle: () => _toggleTodo(todo.id),
  onDelete: () => _deleteTodo(todo.id),
)
```

---

## Deleting Todos

### With Confirmation

```dart
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
          ),
          onPressed: () {
            setState(() {
              _todos.removeWhere((t) => t.id == id);
            });
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
```

### Without Confirmation (Simpler)

```dart
void _deleteTodo(String id) {
  setState(() {
    _todos.removeWhere((t) => t.id == id);
  });
}
```

---

## Showing Feedback

Use SnackBar to confirm actions:

```dart
void _toggleTodo(String id) {
  setState(() {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.toggleComplete();
  });

  final todo = _todos.firstWhere((t) => t.id == id);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        todo.isCompleted ? 'Completed!' : 'Marked as incomplete',
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}
```

---

## Complete Implementation

The full `_TodoListScreenState` class:

```dart
class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _todos.addAll([
      Todo(id: '1', title: 'Learn Flutter', isCompleted: true),
      Todo(id: '2', title: 'Build a Todo app'),
    ]);
  }

  void _addTodo() {
    // Show dialog and add
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((t) => t.id == id);
      todo.toggleComplete();
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return TodoItem(
            todo: todo,
            onToggle: () => _toggleTodo(todo.id),
            onDelete: () => _deleteTodo(todo.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## Common Mistakes

**Forgetting setState():**

```dart
// Wrong - UI won't update
_todos.add(newTodo);

// Correct
setState(() {
  _todos.add(newTodo);
});
```

**Modifying state outside setState():**

```dart
// Works but not recommended
todo.isCompleted = true;
setState(() {});

// Better - mutation inside setState
setState(() {
  todo.isCompleted = true;
});
```

**Calling setState after dispose:**

```dart
// May crash if widget is removed during async operation
await someAsyncOperation();
setState(() {}); // Widget might be gone!

// Check if mounted
await someAsyncOperation();
if (mounted) {
  setState(() {});
}
```

---

## Summary

- StatefulWidget holds mutable state
- setState() notifies Flutter to rebuild
- Add/delete/toggle by modifying the list in setState()
- Dialogs work well for user input
- SnackBars provide action feedback

---

## Exercises

### Exercise 1: Undo Delete

**Objective:** Practice more complex state operations.

**Instructions:**
1. When a todo is deleted, show a SnackBar with an "Undo" action
2. Store the deleted todo temporarily
3. If "Undo" is tapped, add the todo back

### Exercise 2: Clear Completed

**Objective:** Practice batch operations.

**Instructions:**
1. Add a button to clear all completed todos
2. Show a confirmation dialog first
3. Remove all todos where isCompleted is true

### Exercise 3: Todo Counter

**Objective:** Practice derived state.

**Instructions:**
1. Show "X of Y completed" in the AppBar
2. Update automatically when todos change
3. Make it a computed property, not stored state

### Exercise 4: Reorder Todos

**Objective:** Practice list reordering.

**Instructions:**
1. Use ReorderableListView instead of ListView
2. Allow users to drag and drop to reorder
3. Persist the new order in state

---

## Next Steps

In Lesson 9, you'll add forms and validation. You'll create a proper add/edit screen with text fields, and learn to validate user input before saving.
