// 01_classes.dart
// Run with: dart run 01_classes.dart
import 'dart:math';

void main() {
  // --- Creating Objects ---
  print('=== Creating Objects ===');

  var alice = Person('Alice', 30);
  var bob = Person('Bob', 25);

  print('Created: $alice');
  print('Created: $bob');

  alice.introduce();
  bob.introduce();

  // --- Accessing Properties ---
  print('\n=== Accessing Properties ===');

  print('Alice\'s name: ${alice.name}');
  print('Alice\'s age: ${alice.age}');

  // Modify properties
  alice.age = 31;
  print('Alice after birthday: ${alice.age}');

  // --- Methods ---
  print('\n=== Methods ===');

  var rect = Rectangle(10, 5);
  print('Rectangle: ${rect.width} x ${rect.height}');
  print('Area: ${rect.area()}');
  print('Perimeter: ${rect.perimeter()}');

  // --- Getters and Setters ---
  print('\n=== Getters and Setters ===');

  var circle = Circle(5);
  print('Circle radius: ${circle.radius}');
  print('Circle area: ${circle.area}');
  print('Circle circumference: ${circle.circumference}');

  circle.radius = 10;
  print('\nAfter changing radius to 10:');
  print('Area: ${circle.area}');

  // Invalid value ignored by setter
  circle.radius = -5;
  print('After trying to set -5: ${circle.radius}'); // Still 10

  // --- Private Properties ---
  print('\n=== Private Properties ===');

  var account = BankAccount('12345');
  print('Initial balance: ${account.balance}');

  account.deposit(100);
  print('After deposit 100: ${account.balance}');

  account.withdraw(30);
  print('After withdraw 30: ${account.balance}');

  account.withdraw(100); // Will be rejected
  print('After trying to withdraw 100: ${account.balance}');

  // --- Static Members ---
  print('\n=== Static Members ===');

  print('Products created: ${Product.count}');

  var p1 = Product('Laptop', 999.99);
  print('After creating $p1: ${Product.count} products');

  var p2 = Product('Phone', 699.99);
  print('After creating $p2: ${Product.count} products');

  // Static method
  print('Tax on \$100: \$${Product.calculateTax(100)}');

  // --- Cascade Operator ---
  print('\n=== Cascade Operator ===');

  // Without cascade
  var person1 = Person('Charlie', 20);
  person1.name = 'Charles';
  person1.age = 21;
  person1.introduce();

  // With cascade (returns the object, not the result of each call)
  var person2 = Person('Diana', 22)
    ..name = 'Di'
    ..age = 23
    ..introduce();

  // --- Null-aware Cascade ---
  print('\n=== Null-aware Cascade ===');

  Person? maybePerson;

  // Won't crash if maybePerson is null
  maybePerson?..introduce();

  maybePerson = Person('Eve', 25);
  maybePerson?..introduce();

  // --- toString Override ---
  print('\n=== toString Override ===');

  var point = Point(3, 4);
  print('Point: $point'); // Uses toString()

  var distance = point.distanceFromOrigin();
  print('Distance from origin: $distance');

  // --- Equality ---
  print('\n=== Equality ===');

  var p3 = Point(1, 2);
  var p4 = Point(1, 2);
  var p5 = Point(3, 4);

  print('Point(1,2) == Point(1,2): ${p3 == p4}'); // true (we overrode ==)
  print('Point(1,2) == Point(3,4): ${p3 == p5}'); // false

  // Without override, objects are compared by reference
  var rect1 = Rectangle(10, 5);
  var rect2 = Rectangle(10, 5);
  print('Rectangle(10,5) == Rectangle(10,5): ${rect1 == rect2}'); // false
}

// --- Class Definitions ---

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

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

class Circle {
  double _radius; // Private (starts with underscore)

  Circle(this._radius);

  // Getter
  double get radius => _radius;

  // Computed getters
  double get area => 3.14159 * _radius * _radius;
  double get circumference => 2 * 3.14159 * _radius;

  // Setter with validation
  set radius(double value) {
    if (value > 0) {
      _radius = value;
    }
  }
}

class BankAccount {
  final String accountNumber;
  double _balance = 0;

  BankAccount(this.accountNumber);

  // Getter only - no setter means it's read-only from outside
  double get balance => _balance;

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited \$$amount');
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrew \$$amount');
    } else {
      print('Cannot withdraw \$$amount - insufficient funds');
    }
  }
}

class Product {
  String name;
  double price;

  // Static property - shared across all instances
  static int count = 0;

  // Static constant
  static const double taxRate = 0.1;

  Product(this.name, this.price) {
    count++;
  }

  // Static method
  static double calculateTax(double amount) {
    return amount * taxRate;
  }

  @override
  String toString() => 'Product($name, \$$price)';
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceFromOrigin() {
    return sqrt(x * x + y * y);
  }

  @override
  String toString() => 'Point($x, $y)';

  // Override equality
  @override
  bool operator ==(Object other) {
    if (other is! Point) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}
