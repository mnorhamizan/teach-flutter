import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Layouts & Navigation',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore different layout widgets and navigation patterns.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),

          // Quick overview cards
          _FeatureCard(
            icon: Icons.list,
            title: 'ListView',
            description: 'Scrollable lists with ListTile, builder, and separators.',
            color: Colors.blue,
          ),
          _FeatureCard(
            icon: Icons.grid_view,
            title: 'GridView',
            description: 'Grid layouts with fixed columns or max extent.',
            color: Colors.green,
          ),
          _FeatureCard(
            icon: Icons.navigation,
            title: 'Navigation',
            description: 'Push, pop, pass data, and named routes.',
            color: Colors.orange,
          ),
          _FeatureCard(
            icon: Icons.menu,
            title: 'Drawer',
            description: 'Side navigation menu with menu items.',
            color: Colors.purple,
          ),

          const SizedBox(height: 24),
          const Text(
            'Try It Out',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Swipe from the left edge to open the Drawer\n'
            '• Use the bottom navigation to switch tabs\n'
            '• Tap on list/grid items to see navigation in action',
            style: TextStyle(height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
