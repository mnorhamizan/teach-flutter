# Lesson 2: Control Flow

Programs need to make decisions and repeat actions. Control flow structures determine which code runs and how many times. This lesson covers conditionals, loops, and switch statements.

## Learning Objectives

By the end of this lesson, you will be able to:
- Use `if`, `else if`, and `else` to make decisions
- Write `switch` statements for multiple cases
- Create `for` and `while` loops for repetition
- Use `break` and `continue` to control loop execution

## Prerequisites

- Completed Lesson 1 (Dart Basics)
- Understanding of variables, operators, and booleans

---

## Conditional Statements

Conditionals let your code respond to different situations.

### if Statements

The simplest conditional checks one condition:

```dart
int temperature = 35;

if (temperature > 30) {
  print('It is hot');
}
```

The code inside the braces runs only when the condition is `true`.

### if-else Statements

Handle two possibilities:

```dart
int age = 16;

if (age >= 18) {
  print('You can vote');
} else {
  print('You cannot vote yet');
}
```

One branch always executes.

### if-else if-else Chains

Check multiple conditions in sequence:

```dart
int score = 75;

if (score >= 90) {
  print('Grade: A');
} else if (score >= 80) {
  print('Grade: B');
} else if (score >= 70) {
  print('Grade: C');
} else if (score >= 60) {
  print('Grade: D');
} else {
  print('Grade: F');
}
```

Dart evaluates conditions from top to bottom. Once a condition matches, the remaining conditions are skipped. Order matters — put the most specific conditions first.

### Nested Conditionals

You can place conditionals inside other conditionals:

```dart
bool isLoggedIn = true;
bool isAdmin = false;

if (isLoggedIn) {
  if (isAdmin) {
    print('Welcome, Administrator');
  } else {
    print('Welcome, User');
  }
} else {
  print('Please log in');
}
```

Deeply nested conditionals become hard to read. Consider refactoring when you go beyond two levels.

### Conditional Expressions

For simple assignments, use the ternary operator:

```dart
int age = 20;
String status = age >= 18 ? 'adult' : 'minor';
```

This is shorter than a full if-else when you just need to choose between two values.

---

## Switch Statements

When comparing one value against multiple possibilities, `switch` is often clearer than if-else chains.

### Basic Switch

```dart
String day = 'Monday';

switch (day) {
  case 'Monday':
    print('Start of work week');
    break;
  case 'Tuesday':
  case 'Wednesday':
  case 'Thursday':
    print('Midweek');
    break;
  case 'Friday':
    print('Almost weekend');
    break;
  case 'Saturday':
  case 'Sunday':
    print('Weekend');
    break;
  default:
    print('Invalid day');
}
```

Key points:
- Each `case` must end with `break` (or `return`, `throw`, `continue`)
- Multiple cases can share the same code (fall-through)
- `default` handles unmatched values

### Switch Expressions (Dart 3+)

Modern Dart supports switch expressions for concise value selection:

```dart
String day = 'Monday';

String type = switch (day) {
  'Monday' => 'Start of week',
  'Tuesday' || 'Wednesday' || 'Thursday' => 'Midweek',
  'Friday' => 'Almost weekend',
  'Saturday' || 'Sunday' => 'Weekend',
  _ => 'Invalid day'  // _ is the default
};

print(type);
```

Switch expressions return a value and use `=>` instead of `break`. Use the pattern `||` for multiple cases.

### When to Use Switch

Use switch when:
- Comparing one value against many constants
- Each case has distinct behavior
- The cases are mutually exclusive

Use if-else when:
- Conditions involve ranges (`score > 90`)
- Conditions involve multiple variables
- Logic is more complex than equality checks

---

## For Loops

Loops repeat code. Use `for` when you know how many iterations you need.

### Traditional For Loop

```dart
for (int i = 0; i < 5; i++) {
  print('Iteration $i');
}
```

The loop has three parts:
1. **Initialization**: `int i = 0` — runs once before the loop
2. **Condition**: `i < 5` — checked before each iteration
3. **Update**: `i++` — runs after each iteration

### For-in Loop

Use `for-in` to iterate over collections:

```dart
List<String> fruits = ['apple', 'banana', 'cherry'];

for (String fruit in fruits) {
  print(fruit);
}
```

This is cleaner when you don't need the index.

### Iterating with Index

When you need both the value and its position:

```dart
List<String> fruits = ['apple', 'banana', 'cherry'];

for (int i = 0; i < fruits.length; i++) {
  print('$i: ${fruits[i]}');
}
```

Or use `asMap()`:

```dart
for (var entry in fruits.asMap().entries) {
  print('${entry.key}: ${entry.value}');
}
```

### Nested Loops

Loops can contain other loops:

```dart
for (int row = 1; row <= 3; row++) {
  for (int col = 1; col <= 3; col++) {
    print('Row $row, Col $col');
  }
}
```

The inner loop completes all its iterations for each iteration of the outer loop.

---

## While Loops

Use `while` when the number of iterations depends on a condition.

### While Loop

The condition is checked before each iteration:

```dart
int count = 0;

while (count < 5) {
  print('Count: $count');
  count++;
}
```

If the condition is initially false, the loop body never runs.

### Do-While Loop

The condition is checked after each iteration:

```dart
int count = 0;

do {
  print('Count: $count');
  count++;
} while (count < 5);
```

The loop body runs at least once, even if the condition is false.

### Infinite Loops

Be careful not to create loops that never end:

```dart
// This runs forever — don't do this
while (true) {
  print('Forever');
}
```

Infinite loops are occasionally intentional (e.g., game loops, servers), but they must include a way to exit.

### While vs For

Use `for` when:
- The number of iterations is known
- Iterating over a collection
- The loop variable follows a regular pattern

Use `while` when:
- The number of iterations is unknown
- The exit condition depends on something other than a counter
- You need to check a condition that might be false initially

---

## Break and Continue

These keywords modify loop behavior.

### Break

`break` exits the loop immediately:

```dart
for (int i = 0; i < 10; i++) {
  if (i == 5) {
    break;  // Exit when i reaches 5
  }
  print(i);
}
// Output: 0, 1, 2, 3, 4
```

### Continue

`continue` skips to the next iteration:

```dart
for (int i = 0; i < 5; i++) {
  if (i == 2) {
    continue;  // Skip when i is 2
  }
  print(i);
}
// Output: 0, 1, 3, 4
```

### Labels

When working with nested loops, labels let you break or continue a specific loop:

```dart
outer:
for (int i = 0; i < 3; i++) {
  for (int j = 0; j < 3; j++) {
    if (j == 1) {
      break outer;  // Breaks the outer loop
    }
    print('$i, $j');
  }
}
// Output: 0, 0
```

Labels are rarely needed — if you find yourself using them often, consider restructuring your code.

---

## Common Mistakes

**Off-by-one errors:**

```dart
// Runs 5 times (0, 1, 2, 3, 4)
for (int i = 0; i < 5; i++) { }

// Runs 6 times (0, 1, 2, 3, 4, 5)
for (int i = 0; i <= 5; i++) { }
```

Pay attention to `<` vs `<=`.

**Forgetting to update the loop variable:**

```dart
int i = 0;
while (i < 5) {
  print(i);
  // i++ is missing — infinite loop!
}
```

**Using assignment instead of comparison:**

```dart
// Wrong: assigns 5 to x, doesn't compare
if (x = 5) { }

// Correct: compares x to 5
if (x == 5) { }
```

Dart catches this at compile time, but it's a common mistake in other languages.

---

## Summary

- `if`/`else if`/`else` handles conditional branching
- `switch` compares one value against multiple cases
- `for` loops work well when iteration count is known
- `for-in` iterates over collections cleanly
- `while` loops when the exit condition is dynamic
- `do-while` guarantees at least one execution
- `break` exits loops, `continue` skips iterations

---

## Exercises

### Exercise 1: FizzBuzz

**Objective:** Practice conditionals and loops together.

**Instructions:**
1. Create a file called `exercise_01.dart`
2. Write a program that prints numbers 1 to 30
3. For multiples of 3, print "Fizz" instead of the number
4. For multiples of 5, print "Buzz" instead of the number
5. For multiples of both 3 and 5, print "FizzBuzz"

**Expected output (partial):**
```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
...
```

### Exercise 2: Number Guessing Game

**Objective:** Practice while loops and conditionals.

**Instructions:**
1. Create a file called `exercise_02.dart`
2. Set a "secret" number (hardcode it for now)
3. Let the user "guess" by iterating through a list of guesses
4. For each guess, print "Too high", "Too low", or "Correct!"
5. Use `break` to exit the loop when the guess is correct
6. Limit to 5 attempts

**Hint:** Create a list like `[50, 25, 75, 60, 55]` to simulate guesses.

### Exercise 3: Multiplication Table

**Objective:** Practice nested loops.

**Instructions:**
1. Create a file called `exercise_03.dart`
2. Print a multiplication table from 1 to 5
3. Format the output in a grid

**Expected output:**
```
1   2   3   4   5
2   4   6   8   10
3   6   9   12  15
4   8   12  16  20
5   10  15  20  25
```

### Exercise 4: Pattern Printing

**Objective:** Practice loop control and nesting.

**Instructions:**
1. Create a file called `exercise_04.dart`
2. Print the following patterns using nested loops:

Pattern A (right triangle):
```
*
**
***
****
*****
```

Pattern B (inverted triangle):
```
*****
****
***
**
*
```

---

## Next Steps

In Lesson 3, you'll learn about functions and collections. Functions let you organize reusable code, while collections (List, Map, Set) let you work with groups of data.
