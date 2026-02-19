// 04_while_loops.dart
// Run with: dart run 04_while_loops.dart

void main() {
  // --- Basic While Loop ---
  print('=== Basic While Loop ===');

  int count = 0;
  while (count < 5) {
    print('Count: $count');
    count++;
  }
  print('Final count: $count');

  // --- While Loop with Different Conditions ---
  print('\n=== Countdown ===');

  int seconds = 5;
  while (seconds > 0) {
    print('$seconds...');
    seconds--;
  }
  print('Go!');

  // --- While with Boolean Condition ---
  print('\n=== Boolean Condition ===');

  bool running = true;
  int iterations = 0;

  while (running) {
    iterations++;
    print('Iteration $iterations');

    if (iterations >= 3) {
      running = false;
    }
  }
  print('Stopped after $iterations iterations');

  // --- Do-While Loop ---
  print('\n=== Do-While Loop ===');

  // The body executes at least once
  int value = 10;
  do {
    print('Value: $value');
    value++;
  } while (value < 5); // Condition is false, but body ran once

  print('Final value: $value');

  // --- While vs Do-While ---
  print('\n=== While vs Do-While Comparison ===');

  int start = 5;

  // While: checks condition first
  print('While loop (start = 5, condition: < 5):');
  while (start < 5) {
    print('  This never prints');
    start++;
  }
  print('  Loop did not execute');

  // Do-while: executes first, then checks
  start = 5;
  print('\nDo-while loop (start = 5, condition: < 5):');
  do {
    print('  This prints once');
    start++;
  } while (start < 5);
  print('  Loop executed once');

  // --- Break in While Loop ---
  print('\n=== Break in While Loop ===');

  int number = 0;
  while (true) {
    // Infinite loop
    print('Number: $number');
    number++;

    if (number >= 5) {
      print('Breaking out of loop');
      break;
    }
  }

  // --- Continue in While Loop ---
  print('\n=== Continue in While Loop ===');

  int i = 0;
  while (i < 10) {
    i++;

    if (i % 2 == 0) {
      continue; // Skip even numbers
    }

    print('Odd: $i');
  }

  // --- Simulating User Input ---
  print('\n=== Simulated Input Loop ===');

  // Simulating reading input until a specific value
  List<String> inputs = ['hello', 'world', 'quit', 'ignored'];
  int inputIndex = 0;

  while (inputIndex < inputs.length) {
    String input = inputs[inputIndex];
    print('Received: $input');

    if (input == 'quit') {
      print('Quitting...');
      break;
    }

    inputIndex++;
  }

  // --- Number Guessing Game Pattern ---
  print('\n=== Guessing Game Pattern ===');

  int secretNumber = 7;
  List<int> guesses = [3, 9, 5, 7, 10];
  int guessIndex = 0;
  int attempts = 0;
  int maxAttempts = 5;

  while (guessIndex < guesses.length && attempts < maxAttempts) {
    int guess = guesses[guessIndex];
    attempts++;

    print('Attempt $attempts: Guessing $guess');

    if (guess == secretNumber) {
      print('Correct! Found in $attempts attempts');
      break;
    } else if (guess < secretNumber) {
      print('Too low');
    } else {
      print('Too high');
    }

    guessIndex++;
  }

  if (guessIndex >= guesses.length || attempts >= maxAttempts) {
    if (guesses.contains(secretNumber)) {
      // Already found
    } else {
      print('Game over! The number was $secretNumber');
    }
  }

  // --- Nested While Loops ---
  print('\n=== Nested While Loops ===');

  int outer = 1;
  while (outer <= 3) {
    int inner = 1;
    print('Outer: $outer');

    while (inner <= 3) {
      print('  Inner: $inner');
      inner++;
    }

    outer++;
  }

  // --- While with Complex Condition ---
  print('\n=== Complex Conditions ===');

  int x = 0;
  int y = 10;

  while (x < 5 && y > 0) {
    print('x=$x, y=$y');
    x++;
    y -= 2;
  }
  print('Stopped when x=$x, y=$y');

  // --- Waiting Pattern ---
  print('\n=== Waiting Pattern ===');

  // Simulating waiting for a condition
  List<String> statuses = ['pending', 'pending', 'pending', 'complete'];
  int checkIndex = 0;

  print('Waiting for completion...');
  while (checkIndex < statuses.length) {
    String status = statuses[checkIndex];
    print('  Check ${checkIndex + 1}: $status');

    if (status == 'complete') {
      print('Done!');
      break;
    }

    checkIndex++;
  }

  // --- Common Mistake: Infinite Loop ---
  print('\n=== Avoiding Infinite Loops ===');

  // This would be infinite if we forgot i++:
  // while (i < 10) { print(i); }

  // Always ensure the condition will eventually become false
  int safeCounter = 0;
  int maxIterations = 100;

  while (safeCounter < maxIterations) {
    // Do work...
    safeCounter++;

    if (safeCounter == 5) {
      print('Breaking after 5 iterations (safety demonstrated)');
      break;
    }
  }
}
