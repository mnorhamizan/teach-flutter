import 'package:flutter/material.dart';

class ContainerExample extends StatelessWidget {
  const ContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Widget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Basic Container
            _SectionTitle('Basic Container'),
            Container(
              color: Colors.blue,
              child: const Text('Basic container with color'),
            ),
            const SizedBox(height: 24),

            // Section: Size
            _SectionTitle('Fixed Size'),
            Container(
              width: 200,
              height: 100,
              color: Colors.green,
              child: const Center(
                child: Text(
                  '200 x 100',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Padding
            _SectionTitle('Padding'),
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.all(20),
              child: const Text('20px padding all around'),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text('Horizontal: 40, Vertical: 10'),
            ),
            const SizedBox(height: 24),

            // Section: Margin
            _SectionTitle('Margin'),
            Container(
              color: Colors.grey.shade300,
              child: Container(
                color: Colors.purple,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '20px margin',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Border Radius
            _SectionTitle('Border Radius'),
            Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'Rounded corners',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Border
            _SectionTitle('Border'),
            Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Text('With border')),
            ),
            const SizedBox(height: 24),

            // Section: Shadow
            _SectionTitle('Shadow'),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(child: Text('With shadow')),
            ),
            const SizedBox(height: 24),

            // Section: Gradient
            _SectionTitle('Gradient'),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Linear Gradient',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.yellow, Colors.orange],
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('Radial'),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Alignment
            _SectionTitle('Child Alignment'),
            Container(
              width: 200,
              height: 100,
              color: Colors.grey.shade300,
              alignment: Alignment.bottomRight,
              child: const Text('Bottom Right'),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 100,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text('Center'),
            ),
            const SizedBox(height: 24),

            // Section: Combined Example
            _SectionTitle('Card-like Container'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This container combines padding, margin, border radius, and shadow to create a card-like appearance.',
                    style: TextStyle(color: Colors.grey.shade600),
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
