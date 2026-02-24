/// Result of a single AI operation (create, update, or delete).
class OperationResult {
  final String action;
  final bool success;
  final int? todoId;
  final String detail;

  OperationResult({
    required this.action,
    required this.success,
    this.todoId,
    required this.detail,
  });

  factory OperationResult.fromJson(Map<String, dynamic> json) {
    return OperationResult(
      action: json['action'] as String,
      success: json['success'] as bool,
      todoId: json['todo_id'] as int?,
      detail: json['detail'] as String,
    );
  }
}

/// Response from the POST /todos/ai endpoint.
class AiResponse {
  final String query;
  final int operationsRequested;
  final int operationsSucceeded;
  final List<OperationResult> results;

  AiResponse({
    required this.query,
    required this.operationsRequested,
    required this.operationsSucceeded,
    required this.results,
  });

  factory AiResponse.fromJson(Map<String, dynamic> json) {
    return AiResponse(
      query: json['query'] as String,
      operationsRequested: json['operations_requested'] as int,
      operationsSucceeded: json['operations_succeeded'] as int,
      results: (json['results'] as List<dynamic>)
          .map((r) => OperationResult.fromJson(r as Map<String, dynamic>))
          .toList(),
    );
  }
}
