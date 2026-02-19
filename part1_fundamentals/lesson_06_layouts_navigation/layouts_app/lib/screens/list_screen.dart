import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: const TabBar(
              tabs: [
                Tab(text: 'Basic'),
                Tab(text: 'Builder'),
                Tab(text: 'Separated'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _BasicListView(),
                _BuilderListView(),
                _SeparatedListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BasicListView extends StatelessWidget {
  const _BasicListView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Basic ListView',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'A simple ListView with static children.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          5,
          (index) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.primaries[index % Colors.primaries.length],
                child: Text('${index + 1}'),
              ),
              title: Text('Static Item ${index + 1}'),
              subtitle: const Text('This item is defined statically'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: 'Item ${index + 1}',
                      description: 'Details for static item ${index + 1}',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Horizontal ListView',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BuilderListView extends StatelessWidget {
  const _BuilderListView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ListView.builder',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Builds items on demand for better performance with long lists.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.primaries[index % Colors.primaries.length],
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text('Generated Item ${index + 1}'),
                subtitle: Text('Created by itemBuilder at index $index'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        title: 'Item ${index + 1}',
                        description:
                            'This item was generated by ListView.builder.\n\n'
                            'Index: $index\n'
                            'The builder function is only called for visible items, '
                            'making it efficient for long lists.',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SeparatedListView extends StatelessWidget {
  const _SeparatedListView();

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'Alice Johnson', 'email': 'alice@example.com'},
      {'name': 'Bob Smith', 'email': 'bob@example.com'},
      {'name': 'Charlie Brown', 'email': 'charlie@example.com'},
      {'name': 'Diana Prince', 'email': 'diana@example.com'},
      {'name': 'Edward Norton', 'email': 'edward@example.com'},
      {'name': 'Fiona Apple', 'email': 'fiona@example.com'},
      {'name': 'George Lucas', 'email': 'george@example.com'},
      {'name': 'Hannah Montana', 'email': 'hannah@example.com'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ListView.separated',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Adds separators between items using separatorBuilder.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: contacts.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(contact['name']![0]),
                ),
                title: Text(contact['name']!),
                subtitle: Text(contact['email']!),
                trailing: IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email ${contact["name"]}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        title: contact['name']!,
                        description: 'Email: ${contact["email"]}\n\n'
                            'This is a contact card created using '
                            'ListView.separated for clean dividers.',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
