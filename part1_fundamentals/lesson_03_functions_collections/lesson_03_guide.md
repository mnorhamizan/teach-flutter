# Lesson 3: Functions and Collections

Functions organize code into reusable blocks. Collections hold groups of related data. Together, they form the backbone of most programs. This lesson covers function syntax, parameter types, and the three main collection types: List, Map, and Set.

## Learning Objectives

By the end of this lesson, you will be able to:
- Define functions with various parameter types
- Use arrow functions for concise expressions
- Work with Lists to store ordered data
- Use Maps for key-value storage
- Apply Sets for unique values

## Prerequisites

- Completed Lessons 1-2
- Understanding of variables, types, and control flow

---

## Functions

Functions are named blocks of code that perform specific tasks. They make code reusable and easier to understand.

### Basic Function Syntax

```dart
void greet() {
  print('Hello!');
}
```

The function above:
- Returns nothing (`void`)
- Takes no parameters
- Prints a greeting when called

Call it with `greet();`.

### Functions with Return Values

```dart
int add(int a, int b) {
  return a + b;
}
```

The return type (`int`) declares what the function gives back. The `return` statement provides the actual value.

```dart
int result = add(3, 5);  // result = 8
```

### Parameters

**Required parameters** must be provided when calling the function:

```dart
void greetUser(String name) {
  print('Hello, $name');
}

greetUser('Alice');  // Must provide a name
```

**Optional positional parameters** use square brackets:

```dart
void greetUser(String name, [String? greeting]) {
  print('${greeting ?? 'Hello'}, $name');
}

greetUser('Alice');            // Uses default
greetUser('Bob', 'Welcome');   // Uses provided value
```

**Named parameters** use curly braces and can be called in any order:

```dart
void createUser({required String name, int age = 0, String? email}) {
  print('Name: $name, Age: $age, Email: ${email ?? 'N/A'}');
}

createUser(name: 'Alice');
createUser(name: 'Bob', age: 25);
createUser(age: 30, name: 'Charlie', email: 'charlie@example.com');
```

Named parameters are either:
- `required` — must be provided
- Have a default value
- Are nullable (can be omitted)

### Default Values

Parameters can have default values:

```dart
void connect(String host, {int port = 80, bool secure = false}) {
  print('Connecting to $host:$port (secure: $secure)');
}

connect('example.com');                    // Uses defaults
connect('example.com', port: 443, secure: true);
```

### Arrow Functions

When a function contains only one expression, use arrow syntax:

```dart
// Regular function
int multiply(int a, int b) {
  return a * b;
}

// Arrow function
int multiply(int a, int b) => a * b;
```

Arrow functions automatically return the expression's value. They're common for short callbacks:

```dart
List<int> numbers = [1, 2, 3, 4, 5];
numbers.forEach((n) => print(n));
```

### Functions as Values

Functions are first-class objects. You can store them in variables and pass them around:

```dart
int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

var operation = add;
print(operation(5, 3));  // 8

operation = subtract;
print(operation(5, 3));  // 2
```

### Anonymous Functions

Functions without names, often used as callbacks:

```dart
List<int> numbers = [1, 2, 3];

// Anonymous function
numbers.forEach((number) {
  print(number * 2);
});

// Arrow syntax
numbers.map((n) => n * 2);
```

---

## Lists

Lists store ordered collections. Elements are accessed by index, starting at 0.

### Creating Lists

```dart
// Type inference
var fruits = ['apple', 'banana', 'cherry'];

// Explicit type
List<String> vegetables = ['carrot', 'broccoli'];

// Empty list
List<int> numbers = [];
var empty = <String>[];
```

### Accessing Elements

```dart
var fruits = ['apple', 'banana', 'cherry'];

print(fruits[0]);       // apple (first)
print(fruits[2]);       // cherry (third)
print(fruits.first);    // apple
print(fruits.last);     // cherry
print(fruits.length);   // 3
```

### Modifying Lists

```dart
var fruits = ['apple', 'banana'];

// Add elements
fruits.add('cherry');           // Add to end
fruits.insert(0, 'avocado');    // Insert at position

// Remove elements
fruits.remove('banana');        // Remove by value
fruits.removeAt(0);             // Remove by index
fruits.removeLast();            // Remove last element

// Update element
fruits[0] = 'apricot';

// Clear all
fruits.clear();
```

### List Operations

```dart
var numbers = [3, 1, 4, 1, 5, 9, 2, 6];

// Check contents
print(numbers.contains(4));     // true
print(numbers.indexOf(1));      // 1 (first occurrence)
print(numbers.isEmpty);         // false

// Sorting
numbers.sort();                 // [1, 1, 2, 3, 4, 5, 6, 9]

// Reversing
var reversed = numbers.reversed.toList();

// Sublist
var slice = numbers.sublist(1, 4);  // Elements at index 1, 2, 3
```

### Iterating Over Lists

```dart
var colors = ['red', 'green', 'blue'];

// for-in loop
for (var color in colors) {
  print(color);
}

// forEach
colors.forEach((color) => print(color));

// With index
for (int i = 0; i < colors.length; i++) {
  print('$i: ${colors[i]}');
}
```

### Transforming Lists

```dart
var numbers = [1, 2, 3, 4, 5];

// map: transform each element
var doubled = numbers.map((n) => n * 2).toList();
// [2, 4, 6, 8, 10]

// where: filter elements
var evens = numbers.where((n) => n % 2 == 0).toList();
// [2, 4]

// reduce: combine into single value
var sum = numbers.reduce((a, b) => a + b);
// 15

// any/every: check conditions
bool hasEven = numbers.any((n) => n % 2 == 0);    // true
bool allPositive = numbers.every((n) => n > 0);   // true
```

### Spread Operator

Combine lists with `...`:

```dart
var list1 = [1, 2, 3];
var list2 = [4, 5, 6];
var combined = [...list1, ...list2];  // [1, 2, 3, 4, 5, 6]

var withExtra = [0, ...list1, 10];    // [0, 1, 2, 3, 10]
```

---

## Maps

Maps store key-value pairs. Each key maps to exactly one value.

### Creating Maps

```dart
// Type inference
var person = {
  'name': 'Alice',
  'age': 30,
  'city': 'New York',
};

// Explicit type
Map<String, int> scores = {
  'Alice': 95,
  'Bob': 87,
  'Charlie': 92,
};

// Empty map
Map<String, String> empty = {};
var alsoEmpty = <String, int>{};
```

### Accessing Values

```dart
var person = {'name': 'Alice', 'age': 30};

print(person['name']);          // Alice
print(person['unknown']);       // null (key doesn't exist)

// Check if key exists
print(person.containsKey('age'));    // true
print(person.containsValue(30));     // true
```

### Modifying Maps

```dart
var person = {'name': 'Alice'};

// Add or update
person['age'] = 30;             // Add new key
person['name'] = 'Alicia';      // Update existing

// Remove
person.remove('age');

// Add multiple
person.addAll({'city': 'NYC', 'country': 'USA'});

// Clear
person.clear();
```

### Iterating Over Maps

```dart
var scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};

// Keys only
for (var name in scores.keys) {
  print(name);
}

// Values only
for (var score in scores.values) {
  print(score);
}

// Both
for (var entry in scores.entries) {
  print('${entry.key}: ${entry.value}');
}

// forEach
scores.forEach((name, score) {
  print('$name scored $score');
});
```

### Map Properties

```dart
var map = {'a': 1, 'b': 2, 'c': 3};

print(map.length);      // 3
print(map.isEmpty);     // false
print(map.keys);        // (a, b, c)
print(map.values);      // (1, 2, 3)
```

### Practical Example: Counting

```dart
String text = 'hello world';
Map<String, int> charCount = {};

for (var char in text.split('')) {
  charCount[char] = (charCount[char] ?? 0) + 1;
}

print(charCount);
// {h: 1, e: 1, l: 3, o: 2,  : 1, w: 1, r: 1, d: 1}
```

---

## Sets

Sets store unique values with no duplicates. Order is not guaranteed.

### Creating Sets

```dart
// Type inference
var fruits = {'apple', 'banana', 'cherry'};

// Explicit type
Set<int> numbers = {1, 2, 3, 4, 5};

// Empty set (must specify type or use Set())
Set<String> empty = {};
var alsoEmpty = <String>{};
```

Note: `{}` creates an empty Map, not a Set. Use `<type>{}` or `Set<type>()` for empty sets.

### Adding and Removing

```dart
var numbers = {1, 2, 3};

// Add
numbers.add(4);             // {1, 2, 3, 4}
numbers.add(2);             // Still {1, 2, 3, 4} — no duplicates

numbers.addAll([5, 6]);     // {1, 2, 3, 4, 5, 6}

// Remove
numbers.remove(3);          // {1, 2, 4, 5, 6}
numbers.clear();            // {}
```

### Set Operations

Sets support mathematical set operations:

```dart
var a = {1, 2, 3, 4};
var b = {3, 4, 5, 6};

// Union: all elements from both
print(a.union(b));          // {1, 2, 3, 4, 5, 6}

// Intersection: elements in both
print(a.intersection(b));   // {3, 4}

// Difference: elements in a but not b
print(a.difference(b));     // {1, 2}
```

### Checking Membership

```dart
var numbers = {1, 2, 3, 4, 5};

print(numbers.contains(3));         // true
print(numbers.containsAll({2, 4})); // true
print(numbers.length);              // 5
```

### Removing Duplicates from a List

```dart
var withDuplicates = [1, 2, 2, 3, 3, 3, 4];
var unique = withDuplicates.toSet().toList();
print(unique);  // [1, 2, 3, 4]
```

---

## Common Mistakes

**Modifying a list while iterating:**

```dart
// Wrong — causes concurrent modification error
for (var item in list) {
  if (condition) {
    list.remove(item);  // Error!
  }
}

// Correct — use removeWhere or iterate over a copy
list.removeWhere((item) => condition);
```

**Confusing `{}` for empty Set vs Map:**

```dart
var emptyMap = {};           // This is a Map<dynamic, dynamic>
var emptySet = <String>{};   // This is a Set<String>
```

**Accessing Map values without null handling:**

```dart
Map<String, int> ages = {'Alice': 30};

// Wrong — may be null
int age = ages['Bob'];  // Error: can't assign int? to int

// Correct
int? age = ages['Bob'];  // Nullable
int age = ages['Bob'] ?? 0;  // With default
```

---

## Summary

- Functions organize reusable code with parameters and return values
- Arrow functions (`=>`) work for single-expression functions
- Lists store ordered elements accessed by index
- Maps store key-value pairs for lookups
- Sets store unique values with set operations
- Use `map()`, `where()`, and `reduce()` to transform collections

---

## Exercises

### Exercise 1: Function Practice

**Objective:** Practice writing functions with different parameter types.

**Instructions:**
1. Create a file called `exercise_01.dart`
2. Write a function `calculateArea` that:
   - Takes required parameters `width` and `height`
   - Has an optional named parameter `unit` with default value "m"
   - Returns a formatted string like "Area: 50 m²"
3. Write a function `greet` that takes a required `name` and optional `greeting` (default: "Hello")
4. Write an arrow function `isEven` that returns `true` if a number is even

### Exercise 2: Shopping List

**Objective:** Practice List operations.

**Instructions:**
1. Create a file called `exercise_02.dart`
2. Create a shopping list with 5 items
3. Add 2 more items
4. Remove one item by name
5. Check if "milk" is in the list
6. Print all items with their index numbers
7. Sort the list alphabetically

### Exercise 3: Contact Book

**Objective:** Practice Map operations.

**Instructions:**
1. Create a file called `exercise_03.dart`
2. Create a Map storing contacts (name → phone number)
3. Add 3 contacts
4. Update one contact's phone number
5. Check if a contact exists
6. Print all contacts in "Name: Phone" format
7. Count total contacts

### Exercise 4: Unique Words

**Objective:** Practice Set operations.

**Instructions:**
1. Create a file called `exercise_04.dart`
2. Given a sentence, extract all unique words (ignore case)
3. Find common words between two sentences
4. Find words that appear in the first sentence but not the second

**Test with:**
```dart
var sentence1 = "The quick brown fox jumps over the lazy dog";
var sentence2 = "The lazy cat sleeps all day";
```

---

## Next Steps

In Lesson 4, you'll learn Object-Oriented Programming in Dart. You'll create classes to model real-world concepts, use inheritance for code reuse, and understand how Dart's OOP features work in Flutter.
