import 'package:flutter/material.dart';
import '../models/todo.dart';

/// A form screen for adding or editing todos.
///
/// When [existingTodo] is null, creates a new todo.
/// When [existingTodo] is provided, edits that todo.
class TodoFormScreen extends StatefulWidget {
  final Todo? existingTodo;

  const TodoFormScreen({super.key, this.existingTodo});

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Focus nodes for managing keyboard navigation
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  // Selected priority
  Priority _priority = Priority.medium;

  // Track if form has been modified (for unsaved changes warning)
  bool _hasChanges = false;

  bool get _isEditing => widget.existingTodo != null;

  @override
  void initState() {
    super.initState();
    // Pre-fill form if editing an existing todo
    if (widget.existingTodo != null) {
      _titleController.text = widget.existingTodo!.title;
      _descriptionController.text = widget.existingTodo!.description ?? '';
      _priority = widget.existingTodo!.priority;
    }

    // Listen for changes to track modifications
    _titleController.addListener(_onFormChanged);
    _descriptionController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  /// Validates and submits the form.
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        id: widget.existingTodo?.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        isCompleted: widget.existingTodo?.isCompleted ?? false,
        createdAt: widget.existingTodo?.createdAt,
        updatedAt: widget.existingTodo?.updatedAt,
        priority: _priority,
      );
      Navigator.pop(context, todo);
    }
  }

  /// Shows a confirmation dialog when back is pressed with unsaved changes.
  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved changes. Are you sure you want to go back?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Editing'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    return shouldDiscard ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Todo' : 'Add Todo'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                focusNode: _titleFocus,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'What needs to be done?',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  if (value.trim().length < 3) {
                    return 'Title must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description field
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocus,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Add more details...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),

              // Priority selector
              DropdownButtonFormField<Priority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: Priority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Row(
                      children: [
                        _buildPriorityIndicator(priority),
                        const SizedBox(width: 8),
                        Text(priority.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _priority = value;
                      _hasChanges = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _isEditing ? 'Save Changes' : 'Add Todo',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(Priority priority) {
    Color color;
    switch (priority) {
      case Priority.high:
        color = Colors.red;
        break;
      case Priority.medium:
        color = Colors.orange;
        break;
      case Priority.low:
        color = Colors.green;
        break;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
