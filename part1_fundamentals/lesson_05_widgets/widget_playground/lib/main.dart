import 'package:flutter/material.dart';
import 'examples/text_example.dart';
import 'examples/container_example.dart';
import 'examples/row_column_example.dart';
import 'examples/button_example.dart';
import 'examples/stateful_example.dart';
import 'examples/stack_example.dart';

void main() {
  runApp(const WidgetPlayground());
}

class WidgetPlayground extends StatelessWidget {
  const WidgetPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Playground',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Playground'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Explore Flutter Widgets',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            'Tap on any example to see the widget in action.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _ExampleCard(
            title: 'Text Widget',
            description: 'Display and style text',
            icon: Icons.text_fields,
            onTap: () => _navigateTo(context, const TextExample()),
          ),
          _ExampleCard(
            title: 'Container Widget',
            description: 'Styling, sizing, and decoration',
            icon: Icons.crop_square,
            onTap: () => _navigateTo(context, const ContainerExample()),
          ),
          _ExampleCard(
            title: 'Row & Column',
            description: 'Horizontal and vertical layouts',
            icon: Icons.view_column,
            onTap: () => _navigateTo(context, const RowColumnExample()),
          ),
          _ExampleCard(
            title: 'Stack Widget',
            description: 'Overlapping widgets',
            icon: Icons.layers,
            onTap: () => _navigateTo(context, const StackExample()),
          ),
          _ExampleCard(
            title: 'Buttons',
            description: 'Different button types',
            icon: Icons.smart_button,
            onTap: () => _navigateTo(context, const ButtonExample()),
          ),
          _ExampleCard(
            title: 'StatefulWidget',
            description: 'Interactive widgets with state',
            icon: Icons.refresh,
            onTap: () => _navigateTo(context, const StatefulExample()),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ExampleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
