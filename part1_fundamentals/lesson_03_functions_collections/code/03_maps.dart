// 03_maps.dart
// Run with: dart run 03_maps.dart

void main() {
  // --- Creating Maps ---
  print('=== Creating Maps ===');

  // Type inference
  var person = {
    'name': 'Alice',
    'age': 30,
    'city': 'New York',
  };
  print('Person: $person');

  // Explicit type
  Map<String, int> scores = {
    'Alice': 95,
    'Bob': 87,
    'Charlie': 92,
  };
  print('Scores: $scores');

  // Empty map
  Map<String, String> emptyMap = {};
  var anotherEmpty = <String, int>{};
  print('Empty map: $emptyMap');

  // From entries
  var entries = [
    MapEntry('a', 1),
    MapEntry('b', 2),
  ];
  var fromEntries = Map.fromEntries(entries);
  print('From entries: $fromEntries');

  // From two lists
  var keys = ['x', 'y', 'z'];
  var values = [10, 20, 30];
  var fromIterables = Map.fromIterables(keys, values);
  print('From iterables: $fromIterables');

  // --- Accessing Values ---
  print('\n=== Accessing Values ===');

  var user = {
    'name': 'Bob',
    'email': 'bob@example.com',
    'age': 25,
  };
  print('User: $user');

  print('Name: ${user['name']}');
  print('Email: ${user['email']}');
  print('Phone (missing): ${user['phone']}'); // null

  // Safe access with default
  var phone = user['phone'] ?? 'Not provided';
  print('Phone with default: $phone');

  // --- Checking Keys and Values ---
  print('\n=== Checking Keys and Values ===');

  print('containsKey("name"): ${user.containsKey('name')}');
  print('containsKey("phone"): ${user.containsKey('phone')}');
  print('containsValue("Bob"): ${user.containsValue('Bob')}');
  print('containsValue("Unknown"): ${user.containsValue('Unknown')}');

  // --- Adding and Updating ---
  print('\n=== Adding and Updating ===');

  var data = {'a': 1, 'b': 2};
  print('Initial: $data');

  // Add new key
  data['c'] = 3;
  print('After adding "c": $data');

  // Update existing key
  data['a'] = 100;
  print('After updating "a": $data');

  // Add multiple entries
  data.addAll({'d': 4, 'e': 5});
  print('After addAll: $data');

  // putIfAbsent: only adds if key doesn't exist
  data.putIfAbsent('a', () => 999); // Won't change 'a'
  data.putIfAbsent('f', () => 6); // Will add 'f'
  print('After putIfAbsent: $data');

  // Update with function
  data.update('a', (value) => value + 1);
  print('After update "a": $data');

  // Update with default for missing key
  data.update('z', (v) => v + 1, ifAbsent: () => 0);
  print('After update "z" with ifAbsent: $data');

  // --- Removing Entries ---
  print('\n=== Removing Entries ===');

  var items = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5};
  print('Initial: $items');

  // Remove by key
  var removed = items.remove('c');
  print('Removed "c" (value was $removed): $items');

  // Remove where condition matches
  items.removeWhere((key, value) => value > 3);
  print('After removeWhere(value > 3): $items');

  // Clear all
  var toClear = {'x': 1, 'y': 2};
  toClear.clear();
  print('After clear: $toClear');

  // --- Iterating ---
  print('\n=== Iterating ===');

  var capitals = {
    'USA': 'Washington D.C.',
    'UK': 'London',
    'France': 'Paris',
    'Japan': 'Tokyo',
  };
  print('Capitals: $capitals');

  // Iterate keys
  print('\nKeys:');
  for (var country in capitals.keys) {
    print('  $country');
  }

  // Iterate values
  print('\nValues:');
  for (var capital in capitals.values) {
    print('  $capital');
  }

  // Iterate entries
  print('\nEntries:');
  for (var entry in capitals.entries) {
    print('  ${entry.key} -> ${entry.value}');
  }

  // forEach
  print('\nUsing forEach:');
  capitals.forEach((country, capital) {
    print('  The capital of $country is $capital');
  });

  // --- Map Properties ---
  print('\n=== Map Properties ===');

  var props = {'a': 1, 'b': 2, 'c': 3};
  print('Map: $props');

  print('length: ${props.length}');
  print('isEmpty: ${props.isEmpty}');
  print('isNotEmpty: ${props.isNotEmpty}');
  print('keys: ${props.keys}');
  print('values: ${props.values}');

  // --- Transforming Maps ---
  print('\n=== Transforming Maps ===');

  var nums = {'a': 1, 'b': 2, 'c': 3};
  print('Original: $nums');

  // map: transform entries
  var doubled = nums.map((key, value) => MapEntry(key, value * 2));
  print('Values doubled: $doubled');

  // Transform keys and values
  var uppercased = nums.map((key, value) => MapEntry(key.toUpperCase(), value));
  print('Keys uppercased: $uppercased');

  // Filter with entries.where
  var filtered = Map.fromEntries(
    nums.entries.where((e) => e.value > 1),
  );
  print('Values > 1: $filtered');

  // --- Practical Examples ---
  print('\n=== Practical: Word Counter ===');

  var text = 'the quick brown fox jumps over the lazy dog the fox';
  var wordCount = <String, int>{};

  for (var word in text.split(' ')) {
    wordCount[word] = (wordCount[word] ?? 0) + 1;
  }
  print('Word counts: $wordCount');

  print('\n=== Practical: Grouping ===');

  var people = [
    {'name': 'Alice', 'department': 'Engineering'},
    {'name': 'Bob', 'department': 'Sales'},
    {'name': 'Charlie', 'department': 'Engineering'},
    {'name': 'Diana', 'department': 'Sales'},
  ];

  var byDepartment = <String, List<String>>{};
  for (var person in people) {
    var dept = person['department']!;
    var name = person['name']!;
    byDepartment.putIfAbsent(dept, () => []).add(name);
  }
  print('Grouped by department: $byDepartment');

  print('\n=== Practical: Config/Settings ===');

  var config = {
    'host': 'localhost',
    'port': 8080,
    'debug': true,
    'maxConnections': 100,
  };

  // Access with type casting
  String host = config['host'] as String;
  int port = config['port'] as int;
  bool debug = config['debug'] as bool;

  print('Server: $host:$port (debug: $debug)');

  // --- Nested Maps ---
  print('\n=== Nested Maps ===');

  var users = {
    'user1': {
      'name': 'Alice',
      'email': 'alice@example.com',
      'roles': ['admin', 'user'],
    },
    'user2': {
      'name': 'Bob',
      'email': 'bob@example.com',
      'roles': ['user'],
    },
  };

  print('User1 name: ${users['user1']!['name']}');
  print('User2 roles: ${users['user2']!['roles']}');
}
