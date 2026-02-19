import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

/// Service for persisting todos to local storage.
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
