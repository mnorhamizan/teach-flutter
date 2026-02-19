import 'package:flutter/material.dart';

class RowColumnExample extends StatelessWidget {
  const RowColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row & Column'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Basic Row
            _SectionTitle('Basic Row'),
            Container(
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  _ColorBox(Colors.red, 'A'),
                  _ColorBox(Colors.green, 'B'),
                  _ColorBox(Colors.blue, 'C'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Row MainAxisAlignment
            _SectionTitle('Row - MainAxisAlignment'),
            _AlignmentDemo(
              label: 'start',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _threeBoxes(),
              ),
            ),
            _AlignmentDemo(
              label: 'center',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _threeBoxes(),
              ),
            ),
            _AlignmentDemo(
              label: 'end',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _threeBoxes(),
              ),
            ),
            _AlignmentDemo(
              label: 'spaceBetween',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _threeBoxes(),
              ),
            ),
            _AlignmentDemo(
              label: 'spaceEvenly',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _threeBoxes(),
              ),
            ),
            _AlignmentDemo(
              label: 'spaceAround',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _threeBoxes(),
              ),
            ),
            const SizedBox(height: 24),

            // Section: Row CrossAxisAlignment
            _SectionTitle('Row - CrossAxisAlignment'),
            _AlignmentDemo(
              label: 'start',
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _threeBoxesDifferentHeights(),
              ),
            ),
            _AlignmentDemo(
              label: 'center',
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _threeBoxesDifferentHeights(),
              ),
            ),
            _AlignmentDemo(
              label: 'end',
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _threeBoxesDifferentHeights(),
              ),
            ),
            _AlignmentDemo(
              label: 'stretch',
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ColorBox(Colors.red, 'A', width: 50),
                  _ColorBox(Colors.green, 'B', width: 50),
                  _ColorBox(Colors.blue, 'C', width: 50),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Basic Column
            _SectionTitle('Basic Column'),
            Container(
              height: 150,
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  _ColorBox(Colors.red, 'A'),
                  _ColorBox(Colors.green, 'B'),
                  _ColorBox(Colors.blue, 'C'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Expanded
            _SectionTitle('Expanded - Equal Space'),
            Container(
              height: 80,
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Expanded with Flex
            _SectionTitle('Expanded with Flex'),
            Container(
              height: 80,
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red,
                      child: const Center(
                        child:
                            Text('flex: 2', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child:
                            Text('flex: 1', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.blue,
                      child: const Center(
                        child:
                            Text('flex: 1', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Fixed + Expanded
            _SectionTitle('Fixed + Expanded'),
            Container(
              height: 80,
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    color: Colors.red,
                    child: const Center(
                      child: Text('80px', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text('Expanded',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    color: Colors.blue,
                    child: const Center(
                      child: Text('80px', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: SizedBox for Spacing
            _SectionTitle('SizedBox for Spacing'),
            Row(
              children: [
                _ColorBox(Colors.red, 'A'),
                const SizedBox(width: 20),
                _ColorBox(Colors.green, 'B'),
                const SizedBox(width: 20),
                _ColorBox(Colors.blue, 'C'),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Nested Row and Column
            _SectionTitle('Nested Layout'),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _threeBoxes() => [
        _ColorBox(Colors.red, 'A'),
        _ColorBox(Colors.green, 'B'),
        _ColorBox(Colors.blue, 'C'),
      ];

  List<Widget> _threeBoxesDifferentHeights() => [
        _ColorBox(Colors.red, 'A', height: 40),
        _ColorBox(Colors.green, 'B', height: 60),
        _ColorBox(Colors.blue, 'C', height: 80),
      ];
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;
  final double width;
  final double? height;

  const _ColorBox(this.color, this.label, {this.width = 50, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50,
      color: color,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _AlignmentDemo extends StatelessWidget {
  final String label;
  final Widget child;
  final double height;

  const _AlignmentDemo({
    required this.label,
    required this.child,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            height: height,
            color: Colors.grey.shade200,
            child: child,
          ),
        ],
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
