import 'package:flutter/material.dart';

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Widget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Basic Stack
            _SectionTitle('Basic Stack'),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Positioned
            _SectionTitle('Positioned Children'),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _Box(Colors.red, 'Top Left'),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _Box(Colors.green, 'Top Right'),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: _Box(Colors.blue, 'Bottom Left'),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: _Box(Colors.orange, 'Bottom Right'),
                  ),
                  const Center(
                    child: Text(
                      'Center',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Positioned.fill
            _SectionTitle('Positioned.fill'),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(color: Colors.blue.shade100),
                  ),
                  Positioned.fill(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20,
                    child: Container(color: Colors.blue.shade300),
                  ),
                  const Center(
                    child: Text('Nested fills'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Stack Alignment
            _SectionTitle('Stack Alignment'),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('topLeft', style: TextStyle(fontSize: 12)),
                      Container(
                        height: 100,
                        color: Colors.grey.shade200,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            _SmallBox(Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      const Text('center', style: TextStyle(fontSize: 12)),
                      Container(
                        height: 100,
                        color: Colors.grey.shade200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _SmallBox(Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      const Text('bottomRight', style: TextStyle(fontSize: 12)),
                      Container(
                        height: 100,
                        color: Colors.grey.shade200,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            _SmallBox(Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Practical - Badge
            _SectionTitle('Practical: Badge'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _BadgeIcon(icon: Icons.notifications, count: 5),
                _BadgeIcon(icon: Icons.shopping_cart, count: 3),
                _BadgeIcon(icon: Icons.mail, count: 12),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Practical - Profile Card
            _SectionTitle('Practical: Profile Card'),
            const _ProfileCard(),
            const SizedBox(height: 24),

            // Section: Practical - Image Overlay
            _SectionTitle('Practical: Image Overlay'),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade200,
              ),
              child: Stack(
                children: [
                  // Background gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Text at bottom
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beautiful Sunset',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Captured at the beach',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Clip Behavior
            _SectionTitle('Clip Behavior'),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('none', style: TextStyle(fontSize: 12)),
                      Container(
                        height: 80,
                        color: Colors.grey.shade200,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -20,
                              left: 10,
                              child: _SmallBox(Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      const Text('hardEdge', style: TextStyle(fontSize: 12)),
                      Container(
                        height: 80,
                        color: Colors.grey.shade200,
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Positioned(
                              top: -20,
                              left: 10,
                              child: _SmallBox(Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final Color color;
  final String label;

  const _Box(this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SmallBox extends StatelessWidget {
  final Color color;

  const _SmallBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;

  const _BadgeIcon({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cover image with overlapping avatar
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // Content below avatar
          const SizedBox(height: 50),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Flutter Developer',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
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
