// 03_operators.dart
// Run with: dart run 03_operators.dart

void main() {
  // --- Arithmetic Operators ---
  print('=== Arithmetic Operators ===');
  int a = 10;
  int b = 3;

  print('a = $a, b = $b');
  print('a + b = ${a + b}'); // Addition: 13
  print('a - b = ${a - b}'); // Subtraction: 7
  print('a * b = ${a * b}'); // Multiplication: 30
  print('a / b = ${a / b}'); // Division: 3.333... (always double)
  print('a ~/ b = ${a ~/ b}'); // Integer division: 3
  print('a % b = ${a % b}'); // Modulo (remainder): 1

  // Unary operators
  print('\n=== Unary Operators ===');
  int counter = 5;
  print('Initial: $counter');
  print('++counter: ${++counter}'); // Pre-increment: 6
  print('counter++: ${counter++}'); // Post-increment: 6 (then becomes 7)
  print('After post-increment: $counter'); // 7
  print('--counter: ${--counter}'); // Pre-decrement: 6
  print('-counter: ${-counter}'); // Negation: -6

  // --- Comparison Operators ---
  print('\n=== Comparison Operators ===');
  int x = 10;
  int y = 20;
  int z = 10;

  print('x = $x, y = $y, z = $z');
  print('x == y: ${x == y}'); // Equal: false
  print('x == z: ${x == z}'); // Equal: true
  print('x != y: ${x != y}'); // Not equal: true
  print('x < y: ${x < y}'); // Less than: true
  print('x > y: ${x > y}'); // Greater than: false
  print('x <= z: ${x <= z}'); // Less than or equal: true
  print('y >= x: ${y >= x}'); // Greater than or equal: true

  // --- Logical Operators ---
  print('\n=== Logical Operators ===');
  bool isLoggedIn = true;
  bool isAdmin = false;
  bool hasPermission = true;

  print('isLoggedIn = $isLoggedIn');
  print('isAdmin = $isAdmin');
  print('hasPermission = $hasPermission');

  // AND: both must be true
  print('\nisLoggedIn && isAdmin: ${isLoggedIn && isAdmin}'); // false
  print('isLoggedIn && hasPermission: ${isLoggedIn && hasPermission}'); // true

  // OR: at least one must be true
  print('\nisAdmin || hasPermission: ${isAdmin || hasPermission}'); // true
  print('isAdmin || false: ${isAdmin || false}'); // false

  // NOT: inverts the value
  print('\n!isAdmin: ${!isAdmin}'); // true
  print('!isLoggedIn: ${!isLoggedIn}'); // false

  // Combining logical operators
  bool canEdit = isLoggedIn && (isAdmin || hasPermission);
  print('\nCan edit (logged in AND (admin OR has permission)): $canEdit');

  // --- Assignment Operators ---
  print('\n=== Assignment Operators ===');
  int value = 10;
  print('Initial value: $value');

  value += 5; // value = value + 5
  print('After += 5: $value'); // 15

  value -= 3; // value = value - 3
  print('After -= 3: $value'); // 12

  value *= 2; // value = value * 2
  print('After *= 2: $value'); // 24

  value ~/= 4; // value = value ~/ 4
  print('After ~/= 4: $value'); // 6

  value %= 4; // value = value % 4
  print('After %= 4: $value'); // 2

  // --- Null-aware Operators ---
  print('\n=== Null-aware Operators ===');

  // ?? (if-null operator)
  String? name;
  String displayName = name ?? 'Guest';
  print('name is null, displayName: $displayName'); // Guest

  name = 'Alice';
  displayName = name ?? 'Guest';
  print('name is "Alice", displayName: $displayName'); // Alice

  // ??= (null-aware assignment)
  String? username;
  print('username before ??=: $username'); // null
  username ??= 'DefaultUser'; // Assigns only if null
  print('username after ??=: $username'); // DefaultUser
  username ??= 'AnotherUser'; // Won't assign, already has value
  print('username after second ??=: $username'); // DefaultUser

  // --- Conditional (Ternary) Operator ---
  print('\n=== Conditional Operator ===');
  int age = 20;

  // condition ? valueIfTrue : valueIfFalse
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('Age $age: $status'); // Adult

  age = 15;
  status = age >= 18 ? 'Adult' : 'Minor';
  print('Age $age: $status'); // Minor

  // Nested ternary (use sparingly — can be hard to read)
  int score = 75;
  String grade = score >= 90
      ? 'A'
      : score >= 80
          ? 'B'
          : score >= 70
              ? 'C'
              : 'F';
  print('Score $score: Grade $grade'); // C

  // --- Cascade Operator ---
  print('\n=== Cascade Operator ===');
  // Cascades let you chain operations on the same object
  // We'll see more of this with Flutter widgets

  var buffer = StringBuffer();

  // Without cascade:
  buffer.write('Hello');
  buffer.write(' ');
  buffer.write('World');
  print('Without cascade: ${buffer.toString()}');

  // With cascade:
  buffer = StringBuffer()
    ..write('Flutter')
    ..write(' ')
    ..write('is great!');
  print('With cascade: ${buffer.toString()}');
}
