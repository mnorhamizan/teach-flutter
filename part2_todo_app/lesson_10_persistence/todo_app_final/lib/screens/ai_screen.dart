import 'package:flutter/material.dart';
import '../models/ai_response.dart';
import '../services/api_service.dart';

/// Screen that lets users send natural language queries to the AI endpoint.
///
/// Shows an input form, then displays the results of the AI operations.
class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();
  final ApiService _api = ApiService();

  bool _isLoading = false;
  AiResponse? _response;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _api.aiQuery(_queryController.text.trim());
      if (mounted) {
        setState(() {
          _response = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('AI request failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _response != null
              ? _buildResults()
              : _buildInputForm(),
    );
  }

  Widget _buildInputForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Describe what you want to do with your todos in plain English. '
              'The AI can create, update, and delete todos for you.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _queryController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText:
                    'e.g. "Create 3 todos for grocery shopping: milk, eggs, bread"',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a query';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Send to AI'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    final res = _response!;

    return Column(
      children: [
        // Summary card
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  res.operationsSucceeded == res.operationsRequested
                      ? Icons.check_circle
                      : Icons.warning,
                  color: res.operationsSucceeded == res.operationsRequested
                      ? Colors.green
                      : Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${res.operationsSucceeded} of ${res.operationsRequested} '
                    'operations succeeded',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Results list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: res.results.length,
            itemBuilder: (context, index) {
              final result = res.results[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    _iconForAction(result.action),
                    color: result.success ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    '${result.action.toUpperCase()}${result.todoId != null ? ' #${result.todoId}' : ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(result.detail),
                ),
              );
            },
          ),
        ),

        // Done button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Done'),
            ),
          ),
        ),
      ],
    );
  }

  IconData _iconForAction(String action) {
    switch (action) {
      case 'create':
        return Icons.add_circle;
      case 'update':
        return Icons.edit;
      case 'delete':
        return Icons.delete;
      default:
        return Icons.help_outline;
    }
  }
}
