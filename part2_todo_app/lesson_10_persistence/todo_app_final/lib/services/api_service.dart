import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

/// Exception thrown when an API call fails.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}

/// Service that communicates with the FastAPI todo backend.
class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// GET /todos — Fetch all todos from the API.
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw ApiException('Failed to load todos', statusCode: response.statusCode);
    }
  }

  /// POST /todos — Create a new todo. Returns the created todo with server ID.
  Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: _headers,
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Failed to create todo', statusCode: response.statusCode);
    }
  }

  /// PUT /todos/{id} — Update an existing todo. Returns the updated todo.
  Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: _headers,
      body: jsonEncode(todo.toUpdateJson()),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Failed to update todo', statusCode: response.statusCode);
    }
  }

  /// POST /todos/{id}/toggle — Toggle the completed status.
  Future<Todo> toggleTodo(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos/$id/toggle'),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException('Failed to toggle todo', statusCode: response.statusCode);
    }
  }

  /// DELETE /todos/{id} — Delete a todo.
  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
    );

    if (response.statusCode != 204) {
      throw ApiException('Failed to delete todo', statusCode: response.statusCode);
    }
  }
}
