// 03_for_loops.dart
// Run with: dart run 03_for_loops.dart

void main() {
  // --- Basic For Loop ---
  print('=== Basic For Loop ===');

  // Structure: for (initialization; condition; update)
  for (int i = 0; i < 5; i++) {
    print('Iteration $i');
  }

  // --- Counting Down ---
  print('\n=== Counting Down ===');

  for (int i = 5; i > 0; i--) {
    print('Countdown: $i');
  }
  print('Liftoff!');

  // --- Step Size ---
  print('\n=== Custom Step Size ===');

  // Count by 2
  print('Even numbers 0-10:');
  for (int i = 0; i <= 10; i += 2) {
    print(i);
  }

  // Count by 3
  print('\nMultiples of 3:');
  for (int i = 0; i <= 15; i += 3) {
    print(i);
  }

  // --- For-in Loop ---
  print('\n=== For-in Loop ===');

  List<String> fruits = ['apple', 'banana', 'cherry', 'date'];

  print('Fruits:');
  for (String fruit in fruits) {
    print('  - $fruit');
  }

  // Also works with other iterables
  print('\nCharacters in "Dart":');
  for (String char in 'Dart'.split('')) {
    print('  $char');
  }

  // --- For Loop with Index ---
  print('\n=== Loop with Index ===');

  List<String> colors = ['red', 'green', 'blue', 'yellow'];

  for (int i = 0; i < colors.length; i++) {
    print('$i: ${colors[i]}');
  }

  // --- Using asMap() for Index and Value ---
  print('\n=== asMap().entries ===');

  for (var entry in colors.asMap().entries) {
    print('Index ${entry.key}: ${entry.value}');
  }

  // --- Nested Loops ---
  print('\n=== Nested Loops ===');

  // 3x3 grid
  for (int row = 1; row <= 3; row++) {
    for (int col = 1; col <= 3; col++) {
      print('($row, $col)');
    }
  }

  // --- Multiplication Table ---
  print('\n=== Multiplication Table (1-5) ===');

  for (int i = 1; i <= 5; i++) {
    String row = '';
    for (int j = 1; j <= 5; j++) {
      // padLeft ensures alignment
      row += '${(i * j).toString().padLeft(3)} ';
    }
    print(row);
  }

  // --- Break in For Loop ---
  print('\n=== Break ===');

  print('Finding first number > 5:');
  for (int i = 0; i < 10; i++) {
    print('Checking $i...');
    if (i > 5) {
      print('Found: $i');
      break; // Exit the loop
    }
  }
  print('Loop ended');

  // --- Continue in For Loop ---
  print('\n=== Continue ===');

  print('Odd numbers 1-10:');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue; // Skip even numbers
    }
    print(i);
  }

  // --- Labeled Break ---
  print('\n=== Labeled Break ===');

  // Breaking out of nested loops
  outer:
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      print('i=$i, j=$j');
      if (i == 1 && j == 1) {
        print('Breaking outer loop');
        break outer;
      }
    }
  }
  print('After labeled break');

  // --- For Loop with Multiple Variables ---
  print('\n=== Multiple Variables ===');

  // Two pointers moving toward each other
  for (int left = 0, right = 4; left < right; left++, right--) {
    print('left=$left, right=$right');
  }

  // --- Empty Loop Parts ---
  print('\n=== Flexible Loop Structure ===');

  // Initialization outside
  int count = 0;
  for (; count < 3; count++) {
    print('Count: $count');
  }

  // Update inside body
  count = 0;
  for (; count < 3;) {
    print('Count (update in body): $count');
    count++;
  }

  // --- Common Pattern: Accumulator ---
  print('\n=== Accumulator Pattern ===');

  List<int> numbers = [1, 2, 3, 4, 5];
  int sum = 0;

  for (int number in numbers) {
    sum += number;
  }
  print('Sum of $numbers = $sum');

  // Finding max
  int max = numbers[0];
  for (int number in numbers) {
    if (number > max) {
      max = number;
    }
  }
  print('Max of $numbers = $max');

  // --- forEach Method ---
  print('\n=== forEach Method ===');

  // Alternative to for-in using a function
  numbers.forEach((number) {
    print('Number: $number');
  });

  // With arrow function
  print('\nUsing arrow function:');
  numbers.forEach((number) => print('$number squared = ${number * number}'));
}
