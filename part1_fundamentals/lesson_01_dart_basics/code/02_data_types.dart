// 02_data_types.dart
// Run with: dart run 02_data_types.dart

void main() {
  // --- Numbers: int ---
  print('=== int (Whole Numbers) ===');
  int count = 42;
  int negative = -17;
  int hexValue = 0xFF; // 255 in hexadecimal

  print('Count: $count');
  print('Negative: $negative');
  print('Hex 0xFF = $hexValue');

  // --- Numbers: double ---
  print('\n=== double (Decimal Numbers) ===');
  double price = 19.99;
  double scientific = 1.5e10; // 1.5 × 10^10
  double tiny = 2.5e-5; // 0.000025

  print('Price: $price');
  print('Scientific: $scientific');
  print('Tiny: $tiny');

  // --- Number Operations ---
  print('\n=== Number Operations ===');
  int a = 10;
  int b = 3;

  print('a = $a, b = $b');
  print('a + b = ${a + b}'); // 13
  print('a - b = ${a - b}'); // 7
  print('a * b = ${a * b}'); // 30
  print('a / b = ${a / b}'); // 3.333... (always double)
  print('a ~/ b = ${a ~/ b}'); // 3 (integer division)
  print('a % b = ${a % b}'); // 1 (remainder)

  // --- num Type ---
  print('\n=== num Type ===');
  // num can hold either int or double
  num value = 42;
  print('value as int: $value');
  value = 3.14;
  print('value as double: $value');

  // --- Booleans ---
  print('\n=== bool (Boolean) ===');
  bool isLoggedIn = true;
  bool hasPermission = false;

  print('Is logged in: $isLoggedIn');
  print('Has permission: $hasPermission');

  // Booleans from comparisons
  int x = 10;
  int y = 20;

  print('\nx = $x, y = $y');
  print('x < y: ${x < y}'); // true
  print('x == y: ${x == y}'); // false
  print('x != y: ${x != y}'); // true
  print('x >= 10: ${x >= 10}'); // true

  // --- dynamic Type ---
  print('\n=== dynamic Type ===');
  // dynamic opts out of type checking
  dynamic anything = 'Hello';
  print('As String: $anything (${anything.runtimeType})');

  anything = 42;
  print('As int: $anything (${anything.runtimeType})');

  anything = true;
  print('As bool: $anything (${anything.runtimeType})');

  // Be careful: dynamic can lead to runtime errors
  // anything = 'text';
  // print(anything.length);  // OK
  // anything = 42;
  // print(anything.length);  // Runtime error! int has no length

  // --- Type Checking ---
  print('\n=== Type Checking ===');
  var mixed = 42;
  print('Is int: ${mixed is int}'); // true
  print('Is double: ${mixed is double}'); // false
  print('Is num: ${mixed is num}'); // true (int is a subtype of num)

  // --- Type Conversion ---
  print('\n=== Type Conversion ===');

  // String to int
  String numberString = '42';
  int parsed = int.parse(numberString);
  print('"$numberString" parsed to int: $parsed');

  // String to double
  String decimalString = '3.14';
  double parsedDouble = double.parse(decimalString);
  print('"$decimalString" parsed to double: $parsedDouble');

  // Number to String
  int number = 100;
  String asString = number.toString();
  print('$number as String: "$asString"');

  // int to double
  int whole = 5;
  double decimal = whole.toDouble();
  print('$whole as double: $decimal');

  // double to int (truncates)
  double pi = 3.99;
  int truncated = pi.toInt();
  print('$pi as int: $truncated (decimal part is dropped)');
}
