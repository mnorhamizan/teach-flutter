import 'package:flutter/material.dart';

class TextExample extends StatelessWidget {
  const TextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Widget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Basic Text
            _SectionTitle('Basic Text'),
            const Text('This is simple text'),
            const SizedBox(height: 24),

            // Section: Text Styling
            _SectionTitle('Text Styling'),
            const Text(
              'Bold text',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Italic text',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            const Text(
              'Colored text',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Large text',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              'Underlined text',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 8),
            const Text(
              'Letter spacing',
              style: TextStyle(letterSpacing: 4),
            ),
            const SizedBox(height: 24),

            // Section: Combined Styling
            _SectionTitle('Combined Styling'),
            const Text(
              'Multiple styles combined',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Section: Text Overflow
            _SectionTitle('Text Overflow'),
            Container(
              width: 200,
              color: Colors.grey.shade200,
              child: const Text(
                'This is a very long text that will overflow the container',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              color: Colors.grey.shade200,
              child: const Text(
                'This is a very long text that will clip at the edge',
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 24),

            // Section: Max Lines
            _SectionTitle('Max Lines'),
            Container(
              width: 250,
              color: Colors.grey.shade200,
              child: const Text(
                'This is a long paragraph that spans multiple lines. '
                'We can limit the number of lines shown using maxLines. '
                'Extra content will be hidden with ellipsis.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 24),

            // Section: Text Alignment
            _SectionTitle('Text Alignment'),
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Left aligned (default)',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Center aligned',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Right aligned',
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 24),

            // Section: Rich Text
            _SectionTitle('Rich Text (Multiple Styles)'),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'You can '),
                  TextSpan(
                    text: 'mix ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'different ',
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: 'styles ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(text: 'in one text.'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Using Theme
            _SectionTitle('Using Theme Styles'),
            Text(
              'Headline Large',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Title Medium',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Body Large',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Label Small',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
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
