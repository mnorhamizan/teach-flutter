// 03_inheritance.dart
// Run with: dart run 03_inheritance.dart

void main() {
  // --- Basic Inheritance ---
  print('=== Basic Inheritance ===');

  var dog = Dog('Rex', 3);
  var cat = Cat('Whiskers', 2);

  print('Dog: ${dog.name}, age ${dog.age}');
  print('Cat: ${cat.name}, age ${cat.age}');

  dog.speak(); // Rex barks!
  cat.speak(); // Whiskers meows!

  // Dog-specific method
  dog.fetch();

  // --- Calling Parent Methods ---
  print('\n=== Calling Parent Methods ===');

  var employee = Employee('Alice', 50000);
  var manager = Manager('Bob', 60000, 10000);

  print('${employee.name} pay: \$${employee.calculatePay()}');
  print('${manager.name} pay: \$${manager.calculatePay()}'); // Includes bonus

  manager.describe(); // Calls parent method

  // --- Polymorphism ---
  print('\n=== Polymorphism ===');

  // All are Animals, but each speaks differently
  List<Animal> animals = [
    Dog('Max', 5),
    Cat('Luna', 3),
    Bird('Tweety', 1),
  ];

  for (var animal in animals) {
    animal.speak(); // Each animal speaks its way
  }

  // --- Type Checking ---
  print('\n=== Type Checking ===');

  var myDog = Dog('Buddy', 4);

  print('myDog is Dog: ${myDog is Dog}'); // true
  print('myDog is Animal: ${myDog is Animal}'); // true
  print('myDog is Cat: ${myDog is Cat}'); // false

  // Type casting
  Animal someAnimal = Dog('Rocky', 2);

  // Safe cast
  if (someAnimal is Dog) {
    someAnimal.fetch(); // Works because we checked the type
  }

  // --- Protected-like Pattern ---
  print('\n=== Protected-like Pattern ===');

  var counter = DoubleCounter(5);
  counter.increment();
  print('Counter value: ${counter.value}'); // 7 (5 + 2)

  // --- Multi-level Inheritance ---
  print('\n=== Multi-level Inheritance ===');

  var labrador = Labrador('Charlie');
  labrador.speak();
  labrador.fetch();
  labrador.swim();

  // --- Constructor Chaining ---
  print('\n=== Constructor Chaining ===');

  var student = Student('Alice', 20, 'Computer Science');
  print(student);

  var gradStudent = GradStudent('Bob', 25, 'Physics', 'Dr. Smith');
  print(gradStudent);

  // --- Overriding Properties ---
  print('\n=== Overriding Properties ===');

  var shape = Square(5);
  print('Square with side ${shape.side}');
  print('Area: ${shape.area}'); // Uses overridden getter
  print('Perimeter: ${shape.perimeter}');

  // --- covariant Keyword ---
  print('\n=== Covariant Parameters ===');

  var dogKennel = DogKennel();
  dogKennel.add(Dog('Spot', 3));
  // dogKennel.add(Cat('Fluffy', 2));  // Would be compile error

  // --- Runtime Type ---
  print('\n=== Runtime Type ===');

  Animal animal = Dog('Fido', 5);
  print('Declared type: Animal');
  print('Runtime type: ${animal.runtimeType}'); // Dog

  // --- Extension ---
  print('\n=== Extension Methods ===');

  var nums = [1, 2, 3, 4, 5];
  print('Sum: ${nums.sum}'); // Using extension
  print('Average: ${nums.average}');
}

// --- Class Definitions ---

class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void speak() {
    print('$name makes a sound');
  }

  void describe() {
    print('$name is $age years old');
  }
}

class Dog extends Animal {
  Dog(String name, int age) : super(name, age);

  @override
  void speak() {
    print('$name barks!');
  }

  void fetch() {
    print('$name fetches the ball');
  }
}

class Cat extends Animal {
  Cat(String name, int age) : super(name, age);

  @override
  void speak() {
    print('$name meows!');
  }
}

class Bird extends Animal {
  Bird(String name, int age) : super(name, age);

  @override
  void speak() {
    print('$name chirps!');
  }
}

class Employee {
  String name;
  double salary;

  Employee(this.name, this.salary);

  double calculatePay() => salary;

  void describe() {
    print('$name earns \$${calculatePay()}');
  }
}

class Manager extends Employee {
  double bonus;

  Manager(String name, double salary, this.bonus) : super(name, salary);

  @override
  double calculatePay() {
    // Call parent method and add bonus
    return super.calculatePay() + bonus;
  }
}

// Protected-like pattern using private + inheritance
class Counter {
  int _value;

  Counter(this._value);

  int get value => _value;

  void increment() {
    _value++;
  }
}

class DoubleCounter extends Counter {
  DoubleCounter(int initial) : super(initial);

  @override
  void increment() {
    // Can call super's increment
    super.increment();
    super.increment();
  }
}

// Multi-level inheritance
class Labrador extends Dog {
  Labrador(String name) : super(name, 0);

  void swim() {
    print('$name swims!');
  }
}

// Constructor chaining
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person($name, $age)';
}

class Student extends Person {
  String major;

  Student(String name, int age, this.major) : super(name, age);

  @override
  String toString() => 'Student($name, $age, $major)';
}

class GradStudent extends Student {
  String advisor;

  GradStudent(String name, int age, String major, this.advisor)
      : super(name, age, major);

  @override
  String toString() => 'GradStudent($name, $age, $major, advisor: $advisor)';
}

// Overriding properties
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  double get area => width * height;
  double get perimeter => 2 * (width + height);
}

class Square extends Rectangle {
  Square(double side) : super(side, side);

  double get side => width;

  // Optionally override getter for clarity
  @override
  double get area => side * side;
}

// Covariant for type-safe override
class Kennel {
  void add(Animal animal) {
    print('Added ${animal.name}');
  }
}

class DogKennel extends Kennel {
  // covariant allows narrowing the parameter type
  @override
  void add(covariant Dog dog) {
    print('Added dog ${dog.name}');
  }
}

// Extension methods (Dart 2.7+)
extension ListExtensions on List<int> {
  int get sum => fold(0, (a, b) => a + b);
  double get average => isEmpty ? 0 : sum / length;
}
