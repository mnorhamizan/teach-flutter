// 01_variables.dart
// Run with: dart run 01_variables.dart

void main() {
  // --- Type Inference with var ---
  // Dart determines the type from the assigned value
  var name = 'Alice';
  var age = 30;
  var height = 1.75;
  var isStudent = false;

  print('=== Type Inference ===');
  print('Name: $name (${name.runtimeType})');
  print('Age: $age (${age.runtimeType})');
  print('Height: $height (${height.runtimeType})');
  print('Is student: $isStudent (${isStudent.runtimeType})');

  // You can reassign, but only with the same type
  name = 'Bob';
  age = 31;
  print('\nAfter reassignment:');
  print('Name: $name, Age: $age');

  // This would cause an error:
  // name = 42;  // Error: A value of type 'int' can't be assigned to a variable of type 'String'

  // --- Explicit Type Declarations ---
  print('\n=== Explicit Types ===');
  String city = 'New York';
  int population = 8336817;
  double area = 783.8;
  bool isCapital = false;

  print('$city has a population of $population');
  print('Area: $area sq km');

  // --- final vs const ---
  print('\n=== final vs const ===');

  // const: Value must be known at compile time
  const pi = 3.14159;
  const maxRetries = 3;
  const appName = 'My Flutter App';

  print('Pi: $pi');
  print('Max retries: $maxRetries');
  print('App name: $appName');

  // final: Value is assigned once at runtime
  final currentTime = DateTime.now();
  final greeting = 'Hello, $name';

  print('Current time: $currentTime');
  print('Greeting: $greeting');

  // These would cause errors:
  // pi = 3.14;          // Error: Constant variables can't be assigned
  // currentTime = DateTime.now();  // Error: Final variables can only be set once

  // --- Why use final/const? ---
  // 1. Prevents accidental reassignment
  // 2. Documents intent: "this value shouldn't change"
  // 3. const enables compile-time optimizations

  // --- Late Variables ---
  print('\n=== Late Variables ===');
  // 'late' declares a non-nullable variable that's initialized later
  late String description;

  // Some logic that determines the value
  if (age > 18) {
    description = 'Adult';
  } else {
    description = 'Minor';
  }

  print('Description: $description');
}
