# Lesson 9: Forms and User Input

Dialogs work for simple input, but real apps need proper forms. This lesson covers Flutter's Form widget, TextFormField validation, and creating a dedicated screen for adding and editing todos.

## Learning Objectives

By the end of this lesson, you will be able to:
- Create forms with multiple input fields
- Validate user input before saving
- Handle form submission
- Navigate between screens for add/edit operations
- Build a reusable form screen

## Prerequisites

- Completed Lesson 8 (State Management)
- Understanding of navigation from Lesson 6

---

## Forms vs TextFields

In Lesson 8, we used a simple TextField in a dialog. This works for single inputs, but forms offer more:

- **Grouped validation**: Check all fields at once
- **Form state management**: Track whether form has changed
- **Input formatting**: Process text before saving

---

## The Form Widget

A Form wraps input fields and manages their state:

```dart
class TodoFormScreen extends StatefulWidget {
  final Todo? existingTodo;  // null for new, existing for edit

  const TodoFormScreen({super.key, this.existingTodo});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill for editing
    if (widget.existingTodo != null) {
      _titleController.text = widget.existingTodo!.title;
      _descriptionController.text = widget.existingTodo!.description ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTodo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'What needs to be done?',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                if (value.length < 3) {
                  return 'Title must be at least 3 characters';
                }
                return null;  // Valid
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Add more details...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        id: widget.existingTodo?.id ?? generateId(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        isCompleted: widget.existingTodo?.isCompleted ?? false,
      );
      Navigator.pop(context, todo);
    }
  }
}
```

---

## Validation

The `validator` function returns:
- `null` if input is valid
- An error message if invalid

Common validations:

```dart
// Required field
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

// Minimum length
validator: (value) {
  if (value != null && value.length < 3) {
    return 'Must be at least 3 characters';
  }
  return null;
}

// Email format
validator: (value) {
  if (value != null && !value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}
```

---

## Navigating to the Form

From the list screen:

```dart
// Add new todo
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
  }
}

// Edit existing todo
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
  }
}
```

---

## Input Formatting

Process text as the user types:

```dart
TextFormField(
  controller: _titleController,
  textCapitalization: TextCapitalization.sentences,
  inputFormatters: [
    FilteringTextInputFormatter.deny(RegExp(r'\s\s+')),  // No double spaces
  ],
)
```

---

## Focus Management

Control which field is focused:

```dart
final _titleFocus = FocusNode();
final _descriptionFocus = FocusNode();

TextFormField(
  focusNode: _titleFocus,
  textInputAction: TextInputAction.next,
  onFieldSubmitted: (_) {
    FocusScope.of(context).requestFocus(_descriptionFocus);
  },
)

TextFormField(
  focusNode: _descriptionFocus,
  textInputAction: TextInputAction.done,
  onFieldSubmitted: (_) => _submitForm(),
)
```

---

## Common Mistakes

**Not disposing controllers:**

```dart
@override
void dispose() {
  _titleController.dispose();  // Always dispose!
  super.dispose();
}
```

**Forgetting to call validate():**

```dart
// Wrong
void _submit() {
  // Using _titleController.text without validation
}

// Correct
void _submit() {
  if (_formKey.currentState!.validate()) {
    // Safe to use values
  }
}
```

---

## Summary

- Form widget groups and validates inputs
- TextFormField provides built-in validation
- validator returns null (valid) or error message
- GlobalKey<FormState> accesses form methods
- Navigate to form screen and return the result

---

## Exercises

### Exercise 1: Priority Selector

**Objective:** Add a priority field to the form.

**Instructions:**
1. Add a dropdown for priority (low, medium, high)
2. Default to medium
3. Save priority with the todo

### Exercise 2: Date Picker

**Objective:** Add a due date field.

**Instructions:**
1. Add a due date field with showDatePicker
2. Display selected date in a readable format
3. Validate that due date is not in the past

### Exercise 3: Unsaved Changes Warning

**Objective:** Warn before losing changes.

**Instructions:**
1. Track if the form has been modified
2. Show a confirmation dialog when pressing back
3. Allow discarding or continuing editing

---

## Next Steps

In Lesson 10, you'll add data persistence. Todos will be saved to the device and persist between app sessions using SharedPreferences.
