# Lesson 4: Object-Oriented Programming in Dart

Object-Oriented Programming (OOP) organizes code around objects — data structures that combine state (properties) and behavior (methods). Understanding OOP is essential for Flutter because widgets, models, and services are all classes. This lesson covers classes, constructors, inheritance, and mixins.

## Learning Objectives

By the end of this lesson, you will be able to:
- Define classes with properties and methods
- Use different types of constructors
- Apply inheritance to share code between classes
- Work with abstract classes and interfaces
- Use mixins for code reuse

## Prerequisites

- Completed Lessons 1-3
- Understanding of functions and collections

---

## Classes and Objects

A class is a blueprint for creating objects. An object is an instance of a class.

### Defining a Class

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }
}
```

### Creating Objects

```dart
var alice = Person('Alice', 30);
alice.introduce();  // Hi, I am Alice and I am 30 years old.

var bob = Person('Bob', 25);
print(bob.name);    // Bob
```

### Properties

Properties store an object's state. They can be:

```dart
class Product {
  String name;           // Instance property
  double price;
  static int count = 0;  // Class property (shared by all instances)

  Product(this.name, this.price) {
    count++;  // Track how many products exist
  }
}
```

### Methods

Methods define an object's behavior:

```dart
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  double area() {
    return width * height;
  }

  double perimeter() {
    return 2 * (width + height);
  }
}
```

### Getters and Setters

Getters and setters provide controlled access to properties:

```dart
class Circle {
  double _radius;  // Private (underscore prefix)

  Circle(this._radius);

  // Getter
  double get radius => _radius;
  double get area => 3.14159 * _radius * _radius;
  double get circumference => 2 * 3.14159 * _radius;

  // Setter with validation
  set radius(double value) {
    if (value > 0) {
      _radius = value;
    }
  }
}
```

Use getters when:
- You need computed properties
- You want to hide implementation details
- You might add logic later without breaking existing code

---

## Constructors

Constructors create and initialize objects.

### Default Constructor

If you don't define a constructor, Dart provides an empty one:

```dart
class Point {
  double x = 0;
  double y = 0;
}

var p = Point();  // Uses default constructor
```

### Standard Constructor

```dart
class Point {
  double x;
  double y;

  Point(this.x, this.y);  // Shorthand for assigning parameters to properties
}

var p = Point(3, 4);
```

### Named Constructors

Classes can have multiple constructors with different names:

```dart
class Point {
  double x;
  double y;

  Point(this.x, this.y);

  Point.origin() : x = 0, y = 0;

  Point.fromJson(Map<String, double> json)
      : x = json['x'] ?? 0,
        y = json['y'] ?? 0;
}

var p1 = Point(3, 4);
var p2 = Point.origin();
var p3 = Point.fromJson({'x': 5, 'y': 6});
```

### Initializer Lists

Initialize properties before the constructor body runs:

```dart
class Person {
  String name;
  String upperName;

  Person(this.name) : upperName = name.toUpperCase();
}
```

Initializer lists are useful for:
- Setting final fields
- Validating input with assertions
- Calling the parent constructor

### Constant Constructors

For immutable objects, use `const`:

```dart
class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);
}

const origin = Point(0, 0);  // Compile-time constant
```

### Factory Constructors

Factory constructors can return existing instances or subclass instances:

```dart
class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;  // Always returns the same instance
  }

  Logger._internal();

  void log(String message) {
    print('LOG: $message');
  }
}

var logger1 = Logger();
var logger2 = Logger();
print(identical(logger1, logger2));  // true
```

---

## Inheritance

Inheritance lets a class reuse code from another class.

### Extending a Class

```dart
class Animal {
  String name;

  Animal(this.name);

  void speak() {
    print('$name makes a sound');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void speak() {
    print('$name barks');
  }

  void fetch() {
    print('$name fetches the ball');
  }
}
```

The `super` keyword calls the parent class constructor or methods.

### The @override Annotation

Mark methods that override parent behavior:

```dart
class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void speak() {
    print('$name meows');
  }
}
```

While optional, `@override` is good practice — the compiler will warn you if the parent method doesn't exist.

### Calling Parent Methods

Use `super` to call the parent's implementation:

```dart
class Employee {
  String name;
  double baseSalary;

  Employee(this.name, this.baseSalary);

  double calculatePay() => baseSalary;
}

class Manager extends Employee {
  double bonus;

  Manager(String name, double baseSalary, this.bonus)
      : super(name, baseSalary);

  @override
  double calculatePay() => super.calculatePay() + bonus;
}
```

---

## Abstract Classes

Abstract classes define a contract without implementation. They cannot be instantiated directly.

```dart
abstract class Shape {
  double area();      // Abstract method (no body)
  double perimeter(); // Abstract method

  void describe() {   // Concrete method
    print('Area: ${area()}, Perimeter: ${perimeter()}');
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area() => width * height;

  @override
  double perimeter() => 2 * (width + height);
}

class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;

  @override
  double perimeter() => 2 * 3.14159 * radius;
}
```

Abstract classes are useful when:
- You want to define a common interface
- Some methods have implementations, others don't
- You need to enforce that subclasses implement specific methods

### Using Abstract Classes

```dart
void printShapeInfo(Shape shape) {
  shape.describe();  // Works for any Shape subclass
}

var rect = Rectangle(10, 5);
var circle = Circle(7);

printShapeInfo(rect);    // Area: 50.0, Perimeter: 30.0
printShapeInfo(circle);  // Area: 153.9..., Perimeter: 43.9...
```

---

## Interfaces

Dart doesn't have a separate `interface` keyword. Every class is implicitly an interface. Use `implements` to adopt an interface:

```dart
class Printer {
  void printDocument(String doc) {
    print('Printing: $doc');
  }
}

class Scanner {
  void scanDocument() {
    print('Scanning...');
  }
}

class AllInOne implements Printer, Scanner {
  @override
  void printDocument(String doc) {
    print('All-in-one printing: $doc');
  }

  @override
  void scanDocument() {
    print('All-in-one scanning...');
  }
}
```

The difference between `extends` and `implements`:
- `extends`: Inherits implementation (can override)
- `implements`: Must provide all implementations yourself

---

## Mixins

Mixins add functionality to classes without inheritance. They solve the limitation of single inheritance.

### Defining a Mixin

```dart
mixin Swimming {
  void swim() {
    print('Swimming...');
  }
}

mixin Flying {
  void fly() {
    print('Flying...');
  }
}

class Duck with Swimming, Flying {
  void quack() {
    print('Quack!');
  }
}
```

A Duck can now swim, fly, and quack.

### Using Mixins with Classes

```dart
class Animal {
  String name;
  Animal(this.name);
}

mixin Walkable {
  void walk() => print('Walking...');
}

mixin Runnable {
  void run() => print('Running...');
}

class Dog extends Animal with Walkable, Runnable {
  Dog(String name) : super(name);

  void bark() => print('$name barks!');
}

var dog = Dog('Rex');
dog.walk();  // Walking...
dog.run();   // Running...
dog.bark();  // Rex barks!
```

### Mixin Constraints

Restrict which classes can use a mixin:

```dart
class Performer {
  void perform() => print('Performing...');
}

mixin Musical on Performer {
  void playMusic() {
    perform();  // Can call methods from Performer
    print('Playing music...');
  }
}

class Musician extends Performer with Musical {}
// class InvalidClass with Musical {}  // Error: doesn't extend Performer
```

---

## Common Patterns

### The toString Method

Override `toString` for readable object output:

```dart
class Point {
  double x;
  double y;

  Point(this.x, this.y);

  @override
  String toString() => 'Point($x, $y)';
}

print(Point(3, 4));  // Point(3.0, 4.0)
```

### Equality

Override `==` and `hashCode` for value equality:

```dart
class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}

print(Point(1, 2) == Point(1, 2));  // true
```

---

## Common Mistakes

**Forgetting `super` in subclass constructors:**

```dart
class Parent {
  Parent(String name);
}

// Wrong
class Child extends Parent {
  Child();  // Error: Parent doesn't have a no-arg constructor
}

// Correct
class Child extends Parent {
  Child(String name) : super(name);
}
```

**Confusing `extends` and `implements`:**

```dart
class A {
  void method() => print('A');
}

class B extends A {
  // Inherits method(), can override if needed
}

class C implements A {
  @override
  void method() => print('C');  // Must implement
}
```

**Modifying properties from mixins without `on`:**

Mixins can't access instance fields unless they use `on` to require a base class.

---

## Summary

- Classes combine data (properties) and behavior (methods)
- Constructors initialize objects; use named constructors for variants
- Inheritance (`extends`) shares code between related classes
- Abstract classes define contracts for subclasses
- Interfaces (`implements`) require full implementation
- Mixins add functionality without inheritance hierarchy

---

## Exercises

### Exercise 1: Bank Account

**Objective:** Practice classes, properties, and methods.

**Instructions:**
1. Create a `BankAccount` class with:
   - Private `_balance` property
   - `deposit(amount)` method
   - `withdraw(amount)` method (prevent overdraft)
   - `balance` getter
   - `toString()` override
2. Test deposit, withdrawal, and overdraft prevention

### Exercise 2: Shape Hierarchy

**Objective:** Practice inheritance and abstract classes.

**Instructions:**
1. Create an abstract `Shape` class with `area()` and `perimeter()` methods
2. Create `Rectangle`, `Square`, and `Circle` subclasses
3. Create a function that takes a `List<Shape>` and prints each shape's area
4. Test with different shapes

### Exercise 3: Vehicle System

**Objective:** Practice mixins.

**Instructions:**
1. Create mixins: `Electric` (charge), `Gasoline` (refuel), `Autonomous` (selfDrive)
2. Create classes:
   - `ElectricCar` with Electric
   - `HybridCar` with Electric and Gasoline
   - `SelfDrivingCar` with Electric and Autonomous
3. Test the different vehicle capabilities

### Exercise 4: Todo Item

**Objective:** Build a model class for the Todo app.

**Instructions:**
1. Create a `Todo` class with:
   - `id` (String)
   - `title` (String)
   - `description` (optional String)
   - `isCompleted` (bool, default false)
   - `createdAt` (DateTime)
2. Add methods:
   - `toggleComplete()` — switches `isCompleted`
   - `toString()` — returns readable representation
3. Add a factory constructor `Todo.fromJson(Map<String, dynamic> json)`

---

## Next Steps

In Lesson 5, you'll start with Flutter and learn about widgets — the building blocks of Flutter apps. Everything in Flutter is a widget, and they're all classes. The OOP concepts from this lesson will be essential.
