# Lesson 6: Layouts and Navigation

Building real apps requires scrollable content and multiple screens. This lesson covers ListView for scrollable lists, GridView for grid layouts, and Navigator for moving between screens. These patterns appear in almost every Flutter app.

## Learning Objectives

By the end of this lesson, you will be able to:
- Create scrollable lists with ListView
- Build grid layouts with GridView
- Navigate between screens with Navigator
- Pass data between screens
- Use Scaffold features: AppBar, Drawer, BottomNavigationBar

## Prerequisites

- Completed Lesson 5 (Widget Fundamentals)
- Understanding of StatelessWidget and StatefulWidget

---

## ListView

ListView creates scrollable lists of widgets. It handles scrolling automatically and only renders visible items for performance.

### Basic ListView

```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)
```

### ListView.builder

For long or dynamic lists, use `ListView.builder`. It builds items on demand:

```dart
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(child: Text('$index')),
      title: Text('Item $index'),
      subtitle: Text('Subtitle for item $index'),
    );
  },
)
```

Key parameters:
- `itemCount`: Total number of items (optional but recommended)
- `itemBuilder`: Function that builds each item

### ListView.separated

Add separators between items:

```dart
ListView.separated(
  itemCount: 10,
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
  separatorBuilder: (context, index) {
    return Divider();
  },
)
```

### ListTile

A convenient widget for list items:

```dart
ListTile(
  leading: Icon(Icons.person),
  title: Text('John Doe'),
  subtitle: Text('john@example.com'),
  trailing: Icon(Icons.chevron_right),
  onTap: () => print('Tapped'),
)
```

### Horizontal ListView

```dart
SizedBox(
  height: 100,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        width: 100,
        margin: EdgeInsets.all(8),
        color: Colors.blue,
        child: Center(child: Text('$index')),
      );
    },
  ),
)
```

---

## GridView

GridView arranges items in a grid pattern.

### GridView.count

Fixed number of columns:

```dart
GridView.count(
  crossAxisCount: 2,
  children: List.generate(10, (index) {
    return Card(
      child: Center(child: Text('Item $index')),
    );
  }),
)
```

### GridView.builder

For dynamic grids:

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text('$index')),
    );
  },
)
```

### GridView.extent

Specify maximum item width:

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 1.0,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Card(child: Center(child: Text('$index')));
  },
)
```

---

## Navigation

Flutter uses a stack-based navigation model. Screens are "pushed" onto the stack and "popped" off.

### Basic Navigation

Navigate to a new screen:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);
```

Go back:

```dart
Navigator.pop(context);
```

### Passing Data Forward

Send data to the new screen via constructor:

```dart
// Navigate with data
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(item: myItem),
  ),
);

// Receive in the destination
class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Text(item.description),
    );
  }
}
```

### Returning Data

Return data when popping:

```dart
// In the second screen
Navigator.pop(context, 'Selected value');

// In the first screen, await the result
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SelectionScreen()),
);

if (result != null) {
  print('Got: $result');
}
```

### Named Routes

Define routes in MaterialApp for cleaner navigation:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/details': (context) => DetailsScreen(),
    '/settings': (context) => SettingsScreen(),
  },
)

// Navigate using name
Navigator.pushNamed(context, '/details');
```

### Replace Current Screen

Replace instead of stacking:

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

### Clear Stack and Navigate

Go to a screen and remove all previous screens:

```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
  (route) => false,  // Remove all previous routes
);
```

---

## Scaffold Features

### AppBar

```dart
Scaffold(
  appBar: AppBar(
    title: Text('My App'),
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {},
    ),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ],
  ),
)
```

### Drawer

Side navigation menu:

```dart
Scaffold(
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text('Menu', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);  // Close drawer
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
      ],
    ),
  ),
)
```

### BottomNavigationBar

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

### FloatingActionButton

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
)
```

---

## SingleChildScrollView

When you need scrolling for content that isn't a list:

```dart
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      // Lots of content that might overflow
      Text('...long content...'),
    ],
  ),
)
```

---

## Common Mistakes

**ListView in Column without constraints:**

```dart
// Wrong — ListView has infinite height
Column(
  children: [
    ListView(...),  // Error!
  ],
)

// Fixed — constrain the ListView
Column(
  children: [
    Expanded(
      child: ListView(...),
    ),
  ],
)
```

**Forgetting `await` on navigation that returns data:**

```dart
// Wrong — result is a Future, not the actual value
final result = Navigator.push(...);

// Correct
final result = await Navigator.push(...);
```

**Not closing the drawer before navigating:**

```dart
// Close drawer first
Navigator.pop(context);
// Then navigate
Navigator.pushNamed(context, '/settings');
```

---

## Summary

- ListView.builder for efficient scrollable lists
- GridView for grid layouts with GridDelegate
- Navigator.push/pop for stack-based navigation
- Pass data via constructor, return with pop
- Scaffold provides AppBar, Drawer, BottomNavigationBar
- Use Expanded when putting ListView in Column

---

## Exercises

### Exercise 1: Contact List

**Objective:** Practice ListView.builder and navigation.

**Instructions:**
1. Create a list of contacts with name and email
2. Display them in a ListView with ListTile
3. Tapping a contact navigates to a detail screen
4. The detail screen shows full contact info

### Exercise 2: Photo Grid

**Objective:** Practice GridView.

**Instructions:**
1. Create a grid of colored boxes (simulating photos)
2. Use GridView.builder with 3 columns
3. Add spacing between items
4. Tapping an item shows a full-screen view

### Exercise 3: Tab Navigation

**Objective:** Practice BottomNavigationBar.

**Instructions:**
1. Create an app with 3 tabs: Home, Favorites, Profile
2. Each tab shows different content
3. The selected tab should be highlighted
4. Add icons and labels to each tab

### Exercise 4: Settings Drawer

**Objective:** Practice Drawer and navigation.

**Instructions:**
1. Create a Drawer with a header and menu items
2. Menu items: Home, Settings, About, Logout
3. Tapping an item closes the drawer and navigates
4. Add icons to each menu item

---

## Next Steps

In Lesson 7, you'll start building the Todo app. You'll set up the project structure, create the Todo model, and display a basic list of todos. This marks the transition from learning individual concepts to building a complete application.
