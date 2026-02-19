# Lesson 5: Flutter Widget Fundamentals

Flutter apps are built entirely from widgets. A widget is a description of part of a user interface — everything from text and buttons to entire screens. This lesson introduces Flutter's widget model and the most important widgets you'll use.

## Learning Objectives

By the end of this lesson, you will be able to:
- Explain what widgets are and how they compose
- Distinguish between StatelessWidget and StatefulWidget
- Use core widgets: Text, Container, Row, Column, Stack
- Understand the widget tree and how Flutter renders UI
- Use hot reload for rapid development

## Prerequisites

- Completed Lessons 1-4 (Dart fundamentals)
- Flutter SDK installed and configured
- An emulator/simulator or physical device

---

## What is a Widget?

In Flutter, everything visible is a widget. Buttons, text, padding, layout — all widgets. Even the app itself is a widget.

Widgets are:
- **Immutable** — their properties can't change after creation
- **Declarative** — you describe what the UI should look like, not how to build it
- **Composable** — complex UIs are built by combining simple widgets

### The Widget Tree

Widgets form a tree structure. Each widget can contain other widgets:

```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text('My App')
    └── Body
        └── Column
            ├── Text('Hello')
            └── Button
```

When something changes, Flutter rebuilds the affected part of the tree.

---

## Your First Flutter App

Every Flutter app starts with `main()` calling `runApp()`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My App')),
        body: const Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

Key points:
- `MaterialApp` provides Material Design styling
- `Scaffold` provides the basic app structure (app bar, body, etc.)
- `build()` returns the widget tree that represents this widget

---

## StatelessWidget vs StatefulWidget

### StatelessWidget

Use for UI that doesn't change based on user interaction or data updates:

```dart
class Greeting extends StatelessWidget {
  final String name;

  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name!');
  }
}
```

A StatelessWidget:
- Has a `build` method that returns widgets
- Cannot change after it's built
- Is rebuilt when its parent rebuilds with new data

### StatefulWidget

Use when the UI needs to change in response to user actions or data:

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

Key points:
- The widget class creates a `State` object
- The `State` holds mutable data (`_count`)
- `setState()` tells Flutter to rebuild the widget
- The underscore (`_CounterState`) makes the class private

### When to Use Which?

| StatelessWidget | StatefulWidget |
|-----------------|----------------|
| Display-only widgets | Interactive widgets |
| Content from parent | Local state that changes |
| Icons, labels, static images | Forms, animations, counters |

Start with StatelessWidget. Convert to StatefulWidget when you need state.

---

## Core Widgets

### Text

Displays text with optional styling:

```dart
Text('Simple text')

Text(
  'Styled text',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)

Text(
  'A very long text that might not fit on one line',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

### Container

A versatile widget for styling and positioning:

```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ],
  ),
  child: Text('Inside container'),
)
```

Container can specify:
- Size (width, height, constraints)
- Padding and margin
- Decoration (color, border, shadow, gradient)
- Alignment of its child

### Row and Column

Arrange widgets horizontally (Row) or vertically (Column):

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text('Left'),
    Text('Center'),
    Text('Right'),
  ],
)

Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text('Top'),
    Text('Middle'),
    Text('Bottom'),
  ],
)
```

**mainAxisAlignment**: How children are positioned along the main axis
- `Row`: horizontal (left to right)
- `Column`: vertical (top to bottom)

**crossAxisAlignment**: How children are positioned on the cross axis
- `Row`: vertical
- `Column`: horizontal

Common values:
- `start`, `end`, `center`
- `spaceBetween`, `spaceAround`, `spaceEvenly`

### Expanded and Flexible

Control how children share available space:

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

The red container gets 2/3 of the space, blue gets 1/3.

### Stack

Layer widgets on top of each other:

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    Positioned(
      bottom: 10,
      right: 10,
      child: Text('Overlaid text'),
    ),
  ],
)
```

Use `Positioned` to place children at specific positions within the Stack.

### SizedBox

Create fixed-size boxes or spacing:

```dart
SizedBox(
  width: 100,
  height: 50,
  child: Text('Fixed size'),
)

// Common pattern for spacing
Column(
  children: [
    Text('First'),
    SizedBox(height: 20),  // 20px vertical space
    Text('Second'),
  ],
)
```

### Padding

Add space around a widget:

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Padded text'),
)

Padding(
  padding: EdgeInsets.only(left: 20, top: 10),
  child: Text('Asymmetric padding'),
)
```

---

## Buttons

Flutter provides several button types:

```dart
ElevatedButton(
  onPressed: () => print('Pressed'),
  child: Text('Elevated'),
)

TextButton(
  onPressed: () => print('Pressed'),
  child: Text('Text'),
)

OutlinedButton(
  onPressed: () => print('Pressed'),
  child: Text('Outlined'),
)

IconButton(
  onPressed: () => print('Pressed'),
  icon: Icon(Icons.favorite),
)

FloatingActionButton(
  onPressed: () => print('Pressed'),
  child: Icon(Icons.add),
)
```

Set `onPressed` to `null` to disable a button.

---

## Icons and Images

```dart
// Built-in icons
Icon(Icons.home)
Icon(Icons.favorite, color: Colors.red, size: 32)

// Images from assets
Image.asset('assets/logo.png')

// Images from network
Image.network('https://example.com/image.png')
```

---

## Building Widgets with BuildContext

The `build` method receives a `BuildContext`:

```dart
@override
Widget build(BuildContext context) {
  // Access theme
  final theme = Theme.of(context);

  // Access screen size
  final size = MediaQuery.of(context).size;

  return Container();
}
```

`BuildContext` provides access to:
- Theme data
- Screen dimensions
- Navigator for routing
- Inherited widgets (state management)

---

## Hot Reload

One of Flutter's best features. When you save a file:
- Changes appear instantly (usually < 1 second)
- App state is preserved
- No need to restart

Hot reload works by injecting updated code. It won't work when:
- Changing `main()` or initialization code
- Adding/removing fields from State classes
- Changing generic type arguments

When hot reload fails, use **hot restart** (loses state) or full restart.

---

## Common Mistakes

**Forgetting `const` for immutable widgets:**

```dart
// Without const — new instance created each build
child: Text('Hello')

// With const — reuses the same instance
child: const Text('Hello')
```

Using `const` improves performance by avoiding unnecessary rebuilds.

**Putting Row/Column inside unbounded parents:**

```dart
// Error — Row has infinite width inside another Row
Row(
  children: [
    Row(children: [...]),  // Needs Expanded
  ],
)

// Fixed
Row(
  children: [
    Expanded(child: Row(children: [...])),
  ],
)
```

**Modifying state without setState:**

```dart
// Wrong — UI won't update
_count++;

// Correct — triggers rebuild
setState(() {
  _count++;
});
```

---

## Summary

- Widgets are the building blocks of Flutter UIs
- StatelessWidget for static content, StatefulWidget for interactive content
- Row/Column for linear layouts, Stack for overlapping
- Container for styling, SizedBox for fixed sizes
- Use `const` for immutable widgets
- Hot reload enables rapid development

---

## Exercises

### Exercise 1: Profile Card

**Objective:** Practice Container, Row, and Column.

**Instructions:**
1. Create a profile card with:
   - A colored Container with rounded corners
   - An Icon for the avatar
   - Name and email Text widgets in a Column
   - A Row to arrange avatar and info side by side
2. Add padding and spacing

### Exercise 2: Button Counter

**Objective:** Practice StatefulWidget and setState.

**Instructions:**
1. Create a counter that displays a number
2. Add "+" and "-" buttons
3. The count should update when buttons are pressed
4. Add a "Reset" button that sets count to 0

### Exercise 3: Color Boxes

**Objective:** Practice Row, Column, and Expanded.

**Instructions:**
1. Create a 3x3 grid of colored boxes
2. Each row should have 3 boxes that share space equally
3. Make the boxes different colors

### Exercise 4: Overlay Layout

**Objective:** Practice Stack and Positioned.

**Instructions:**
1. Create a Stack with a large background Container
2. Add a badge (small circle) in the top-right corner
3. Add centered text on the background

---

## Next Steps

In Lesson 6, you'll learn about layouts and navigation — how to create scrollable lists, grids, and move between screens. You'll use ListView, GridView, and Navigator to build more complex app structures.
