import 'package:flutter/material.dart';
import 'detail_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Navigation Patterns',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Different ways to navigate between screens.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // Basic push
          _NavigationCard(
            title: 'Navigator.push',
            description: 'Navigate to a new screen',
            icon: Icons.arrow_forward,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(
                    title: 'Pushed Screen',
                    description: 'This screen was pushed onto the navigation stack.\n\n'
                        'Use the back button or Navigator.pop() to go back.',
                  ),
                ),
              );
            },
          ),

          // Pass and receive data
          _NavigationCard(
            title: 'Pass & Return Data',
            description: 'Send data and get result back',
            icon: Icons.swap_horiz,
            onTap: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => const _SelectionScreen(),
                ),
              );

              if (result != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: $result'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),

          // Named route
          _NavigationCard(
            title: 'Named Routes',
            description: 'Navigate using route names',
            icon: Icons.label,
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),

          // Replace
          _NavigationCard(
            title: 'Navigator.pushReplacement',
            description: 'Replace current screen',
            icon: Icons.find_replace,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(
                    title: 'Replacement Screen',
                    description:
                        'This screen replaced the Navigation Demo screen.\n\n'
                        'The back button will go to the previous screen before that.',
                  ),
                ),
              );
            },
          ),

          // Modal bottom sheet
          _NavigationCard(
            title: 'Modal Bottom Sheet',
            description: 'Show a sheet from the bottom',
            icon: Icons.keyboard_arrow_up,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bottom Sheet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'This is a modal bottom sheet. It slides up from the bottom '
                        'and can be dismissed by swiping down or tapping outside.',
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Dialog
          _NavigationCard(
            title: 'Alert Dialog',
            description: 'Show a dialog popup',
            icon: Icons.warning,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Action'),
                  content: const Text(
                    'This is an AlertDialog. Use it for confirmations '
                    'or important messages.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Confirmed!')),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NavigationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _NavigationCard({
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

class _SelectionScreen extends StatelessWidget {
  const _SelectionScreen();

  @override
  Widget build(BuildContext context) {
    final options = ['Option A', 'Option B', 'Option C', 'Option D'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Option'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select an option to return it to the previous screen.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(options[index]),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context, options[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
