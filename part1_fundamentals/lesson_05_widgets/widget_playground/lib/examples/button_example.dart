import 'package:flutter/material.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: ElevatedButton
            _SectionTitle('ElevatedButton'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _showSnackBar(context, 'ElevatedButton pressed'),
                  child: const Text('Elevated'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showSnackBar(context, 'With icon'),
                  icon: const Icon(Icons.add),
                  label: const Text('With Icon'),
                ),
                const ElevatedButton(
                  onPressed: null, // Disabled
                  child: Text('Disabled'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: TextButton
            _SectionTitle('TextButton'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () => _showSnackBar(context, 'TextButton pressed'),
                  child: const Text('Text Button'),
                ),
                TextButton.icon(
                  onPressed: () => _showSnackBar(context, 'With icon'),
                  icon: const Icon(Icons.info),
                  label: const Text('With Icon'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: OutlinedButton
            _SectionTitle('OutlinedButton'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => _showSnackBar(context, 'OutlinedButton pressed'),
                  child: const Text('Outlined'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _showSnackBar(context, 'With icon'),
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: IconButton
            _SectionTitle('IconButton'),
            Row(
              children: [
                IconButton(
                  onPressed: () => _showSnackBar(context, 'Favorite'),
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () => _showSnackBar(context, 'Share'),
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () => _showSnackBar(context, 'More'),
                  icon: const Icon(Icons.more_vert),
                ),
                IconButton.filled(
                  onPressed: () => _showSnackBar(context, 'Filled'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: FloatingActionButton
            _SectionTitle('FloatingActionButton'),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                FloatingActionButton.small(
                  onPressed: () => _showSnackBar(context, 'Small FAB'),
                  heroTag: 'small',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () => _showSnackBar(context, 'Regular FAB'),
                  heroTag: 'regular',
                  child: const Icon(Icons.edit),
                ),
                FloatingActionButton.extended(
                  onPressed: () => _showSnackBar(context, 'Extended FAB'),
                  heroTag: 'extended',
                  icon: const Icon(Icons.navigation),
                  label: const Text('Navigate'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Styled Buttons
            _SectionTitle('Styled Buttons'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Green'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Large Padding'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Rounded'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Full Width Button
            _SectionTitle('Full Width Button'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showSnackBar(context, 'Full width'),
                child: const Text('Full Width Button'),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Button Row
            _SectionTitle('Button Row'),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Loading Button
            _SectionTitle('Loading State Pattern'),
            const _LoadingButton(),
            const SizedBox(height: 24),

            // Section: Toggle Buttons
            _SectionTitle('Toggle Buttons'),
            const _ToggleExample(),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _LoadingButton extends StatefulWidget {
  const _LoadingButton();

  @override
  State<_LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<_LoadingButton> {
  bool _isLoading = false;

  void _handlePress() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      child: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Submit'),
    );
  }
}

class _ToggleExample extends StatefulWidget {
  const _ToggleExample();

  @override
  State<_ToggleExample> createState() => _ToggleExampleState();
}

class _ToggleExampleState extends State<_ToggleExample> {
  final List<bool> _selected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _selected,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < _selected.length; i++) {
            _selected[i] = i == index;
          }
        });
      },
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Day'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Week'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Month'),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
