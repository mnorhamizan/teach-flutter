# Lesson 1: Dart Basics

Dart is the programming language behind Flutter. Before building apps, you need to understand how Dart handles data. This lesson covers variables, data types, null safety, and operators.

## Learning Objectives

By the end of this lesson, you will be able to:
- Declare variables using `var`, `final`, and `const`
- Work with common data types: String, int, double, bool
- Handle nullable values safely
- Use operators for calculations and comparisons

## Prerequisites

- Completed environment setup (Lesson 0)
- Terminal/command line basics

---

## Variables

Variables store data that your program uses. Dart provides several ways to declare them, each with different behavior.

### Type Inference with `var`

When you use `var`, Dart figures out the type from the value you assign:

```dart
var name = 'Alice';     // Dart infers String
var age = 30;           // Dart infers int
var height = 1.75;      // Dart infers double
var isStudent = false;  // Dart infers bool
```

Once a variable has a type, you can't assign a different type to it:

```dart
var name = 'Alice';
name = 'Bob';       // OK — still a String
name = 42;          // Error — can't assign int to String
```

This is **type safety**. It catches errors at compile time rather than when your app crashes.

### Explicit Type Declarations

You can also declare the type yourself:

```dart
String name = 'Alice';
int age = 30;
double height = 1.75;
bool isStudent = false;
```

Use explicit types when:
- The initial value doesn't make the type obvious
- You want to document what a variable holds
- You're declaring a variable without an initial value

### `final` and `const`

Not all values need to change. Dart provides two keywords for values that stay constant.

**`final`** — assigned once, at runtime:

```dart
final currentTime = DateTime.now();  // Calculated when code runs
final userName = getUserFromDatabase();  // Value from a function
```

**`const`** — fixed at compile time:

```dart
const pi = 3.14159;           // Known before the program runs
const maxAttempts = 3;
const appTitle = 'My App';
```

The difference matters because `const` values are completely determined before your app runs, while `final` values are determined once during execution.

Use `final` by default when you don't need to reassign a variable. Use `const` for true constants like configuration values.

---

## Data Types

This section covers the data types you'll use most often.

### Numbers: int and double

`int` holds whole numbers. `double` holds decimal numbers.

```dart
int count = 42;
int negative = -17;

double price = 19.99;
double scientific = 1.5e10;  // 1.5 × 10^10
```

Dart also has `num`, which can hold either type:

```dart
num value = 42;
value = 3.14;  // Both work
```

Common operations:

```dart
int a = 10;
int b = 3;

print(a + b);   // 13
print(a - b);   // 7
print(a * b);   // 30
print(a / b);   // 3.333... (always returns double)
print(a ~/ b);  // 3 (integer division)
print(a % b);   // 1 (remainder)
```

### Strings

Strings hold text. Use single or double quotes:

```dart
String single = 'Hello';
String double = "World";
```

**String interpolation** embeds values directly:

```dart
var name = 'Alice';
var age = 30;

print('Name: $name');           // Simple variable
print('Age next year: ${age + 1}');  // Expression needs braces
```

Multi-line strings use triple quotes:

```dart
var address = '''
123 Main Street
Apartment 4B
New York, NY 10001
''';
```

### Booleans

`bool` holds `true` or `false`:

```dart
bool isLoggedIn = true;
bool hasPermission = false;
```

Booleans are the result of comparisons:

```dart
var x = 10;
var y = 20;

print(x < y);   // true
print(x == y);  // false
print(x != y);  // true
```

### The dynamic Type

`dynamic` opts out of type checking. The type can change:

```dart
dynamic anything = 'Hello';
anything = 42;      // OK
anything = true;    // Also OK
```

Avoid `dynamic` when possible. It removes the safety that catches bugs at compile time.

---

## Null Safety

Null represents "no value." Before null safety, any variable could be null, leading to crashes. Dart now requires you to explicitly handle null.

### Nullable Types

By default, variables cannot be null:

```dart
String name = 'Alice';
name = null;  // Error — String can't be null
```

Add `?` to allow null:

```dart
String? name = 'Alice';
name = null;  // OK — String? can be null
```

### Why This Matters

Consider this code without null safety:

```dart
String name = getUserName();  // Might return null
print(name.length);           // Crashes if name is null
```

With null safety, the compiler forces you to handle the null case.

### Handling Nullable Values

**Null check:**

```dart
String? name = getName();

if (name != null) {
  print(name.length);  // Safe — we checked
}
```

**Default value with `??`:**

```dart
String? name = getName();
print(name ?? 'Unknown');  // Uses 'Unknown' if name is null
```

**Null-aware assignment `??=`:**

```dart
String? name;
name ??= 'Default';  // Assigns only if name is null
```

**Null assertion `!`:**

```dart
String? name = getName();
print(name!.length);  // Crashes if null — use only when certain
```

The assertion operator tells Dart "I guarantee this isn't null." If you're wrong, the app crashes. Use it sparingly.

---

## Operators

### Arithmetic Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `+` | Addition | `5 + 3` → `8` |
| `-` | Subtraction | `5 - 3` → `2` |
| `*` | Multiplication | `5 * 3` → `15` |
| `/` | Division | `5 / 2` → `2.5` |
| `~/` | Integer division | `5 ~/ 2` → `2` |
| `%` | Modulo (remainder) | `5 % 2` → `1` |

### Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `==` | Equal | `5 == 5` → `true` |
| `!=` | Not equal | `5 != 3` → `true` |
| `<` | Less than | `3 < 5` → `true` |
| `>` | Greater than | `5 > 3` → `true` |
| `<=` | Less than or equal | `3 <= 3` → `true` |
| `>=` | Greater than or equal | `5 >= 5` → `true` |

### Logical Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `&&` | AND | `true && false` → `false` |
| `\|\|` | OR | `true \|\| false` → `true` |
| `!` | NOT | `!true` → `false` |

### Assignment Operators

```dart
var x = 10;

x += 5;   // x = x + 5  → 15
x -= 3;   // x = x - 3  → 12
x *= 2;   // x = x * 2  → 24
x ~/= 4;  // x = x ~/ 4 → 6
```

---

## Common Mistakes

**Using `=` instead of `==` in comparisons:**

```dart
if (x = 5) { }   // Wrong — this is assignment
if (x == 5) { }  // Correct — this is comparison
```

**Forgetting null checks:**

```dart
String? name;
print(name.length);   // Error — name might be null
print(name?.length);  // OK — returns null if name is null
```

**Using `const` for runtime values:**

```dart
const time = DateTime.now();  // Error — not known at compile time
final time = DateTime.now();  // OK — computed at runtime
```

---

## Summary

- Use `var` for type inference, explicit types for clarity
- Use `final` for values assigned once, `const` for compile-time constants
- Add `?` to types that can be null
- Use `??` for default values, `?.` for safe access
- Operators work as expected; `~/` is integer division

---

## Exercises

### Exercise 1: Variable Practice

**Objective:** Practice declaring different types of variables.

**Instructions:**
1. Create a file called `exercise_01.dart`
2. Declare variables for:
   - Your name (String)
   - Your age (int)
   - Your height in meters (double)
   - Whether you're a student (bool)
3. Print all values using string interpolation
4. Try changing one variable to `final` and reassigning it — observe the error

**Expected output:**
```
Name: [Your name]
Age: [Your age]
Height: [Your height]m
Student: [true/false]
```

### Exercise 2: Calculator

**Objective:** Practice arithmetic operators.

**Instructions:**
1. Create a file called `exercise_02.dart`
2. Declare two number variables
3. Print the result of: addition, subtraction, multiplication, division, integer division, and modulo
4. Calculate and print the average of the two numbers

### Exercise 3: Null Safety Practice

**Objective:** Practice working with nullable types.

**Instructions:**
1. Create a file called `exercise_03.dart`
2. Declare a nullable String variable (don't assign a value)
3. Try to print its length — fix the error using a null check
4. Use `??=` to assign a default value
5. Print the final value

### Exercise 4: Temperature Converter

**Objective:** Apply what you've learned in a practical scenario.

**Instructions:**
1. Create a file called `exercise_04.dart`
2. Declare a temperature in Celsius
3. Convert it to Fahrenheit using the formula: `F = C × 9/5 + 32`
4. Print both values with appropriate labels
5. Bonus: Check if the temperature is above freezing (32°F) and print a message

---

## Next Steps

In Lesson 2, you'll learn control flow — how to make decisions with `if`/`else` and repeat actions with loops. These structures let your code respond to different conditions.
