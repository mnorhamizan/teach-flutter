// 04_abstract_mixins.dart
// Run with: dart run 04_abstract_mixins.dart
import 'dart:math';

void main() {
  // --- Abstract Classes ---
  print('=== Abstract Classes ===');

  // Can't instantiate abstract class:
  // var shape = Shape();  // Error!

  var circle = Circle(5);
  var rectangle = Rectangle(10, 5);
  var triangle = Triangle(3, 4, 5);

  print('Circle: area = ${circle.area()}, perimeter = ${circle.perimeter()}');
  print(
      'Rectangle: area = ${rectangle.area()}, perimeter = ${rectangle.perimeter()}');
  print(
      'Triangle: area = ${triangle.area()}, perimeter = ${triangle.perimeter()}');

  // --- Using Abstract Type ---
  print('\n=== Polymorphism with Abstract Class ===');

  List<Shape> shapes = [
    Circle(3),
    Rectangle(4, 5),
    Circle(2),
    Rectangle(6, 3),
  ];

  double totalArea = 0;
  for (var shape in shapes) {
    totalArea += shape.area();
    shape.describe(); // Concrete method from abstract class
  }
  print('Total area: $totalArea');

  // --- Interfaces (implements) ---
  print('\n=== Interfaces ===');

  var car = Car();
  car.start();
  car.stop();
  car.describe();

  // Can treat Car as either interface
  Drivable vehicle = car;
  vehicle.start();

  Describable item = car;
  item.describe();

  // --- Multiple Interfaces ---
  print('\n=== Multiple Interfaces ===');

  var smartDevice = SmartDevice();
  smartDevice.turnOn();
  smartDevice.connect();

  // --- Mixins ---
  print('\n=== Mixins ===');

  var duck = Duck('Donald');
  duck.walk();
  duck.swim();
  duck.fly();
  duck.quack();

  var penguin = Penguin('Pingu');
  penguin.walk();
  penguin.swim();
  // penguin.fly();  // Penguins can't fly!
  penguin.chirp();

  // --- Mixin Order Matters ---
  print('\n=== Mixin Order ===');

  var a = A();
  a.greet(); // From C (last mixin wins)

  var b = B();
  b.greet(); // From D (last mixin wins)

  // --- Mixin with on Keyword ---
  print('\n=== Mixin Constraints ===');

  var musician = Musician('Alice');
  musician.perform();
  musician.playMusic();

  // --- Practical Example: Flutter-like Widget ---
  print('\n=== Practical: Widget-like Pattern ===');

  var button = Button('Click me');
  button.build();

  var textField = TextField('Enter name');
  textField.build();

  // --- Combining Abstract, Mixin, Interface ---
  print('\n=== Combining Patterns ===');

  var player = MusicPlayer();
  player.play('song.mp3');
  player.pause();
  player.adjustVolume(0.8);
  player.log('Player ready');

  // --- Sealed-like Pattern ---
  print('\n=== Sealed-like Pattern ===');

  var result = fetchData(true);
  handleResult(result);

  result = fetchData(false);
  handleResult(result);

  // --- Extension Types (Preview) ---
  print('\n=== Type Aliases ===');

  UserId userId = '12345';
  print('User ID: $userId');
}

// --- Abstract Class ---

abstract class Shape {
  // Abstract methods (no implementation)
  double area();
  double perimeter();

  // Concrete method (has implementation)
  void describe() {
    print('Area: ${area()}, Perimeter: ${perimeter()}');
  }
}

class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;

  @override
  double perimeter() => 2 * 3.14159 * radius;
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

class Triangle extends Shape {
  double a, b, c; // sides

  Triangle(this.a, this.b, this.c);

  @override
  double area() {
    // Heron's formula
    var s = (a + b + c) / 2;
    return sqrt(s * (s - a) * (s - b) * (s - c));
  }

  @override
  double perimeter() => a + b + c;
}

// --- Interfaces ---

class Drivable {
  void start() => print('Starting...');
  void stop() => print('Stopping...');
}

class Describable {
  void describe() => print('Describing...');
}

// implements requires you to provide all implementations
class Car implements Drivable, Describable {
  @override
  void start() => print('Car engine starting...');

  @override
  void stop() => print('Car engine stopping...');

  @override
  void describe() => print('This is a car');
}

// --- Multiple Interfaces ---

abstract class Switchable {
  void turnOn();
  void turnOff();
}

abstract class Connectable {
  void connect();
  void disconnect();
}

class SmartDevice implements Switchable, Connectable {
  @override
  void turnOn() => print('Device turned on');

  @override
  void turnOff() => print('Device turned off');

  @override
  void connect() => print('Device connected');

  @override
  void disconnect() => print('Device disconnected');
}

// --- Mixins ---

mixin Walkable {
  void walk() => print('Walking...');
}

mixin Swimmable {
  void swim() => print('Swimming...');
}

mixin Flyable {
  void fly() => print('Flying...');
}

class Bird {
  String name;
  Bird(this.name);
}

class Duck extends Bird with Walkable, Swimmable, Flyable {
  Duck(String name) : super(name);
  void quack() => print('$name says quack!');
}

class Penguin extends Bird with Walkable, Swimmable {
  Penguin(String name) : super(name);
  void chirp() => print('$name chirps!');
}

// --- Mixin Order ---

mixin C {
  void greet() => print('Hello from C');
}

mixin D {
  void greet() => print('Hello from D');
}

class A with C, D {} // D wins

class B with D, C {} // C wins

// --- Mixin with on Constraint ---

class Performer {
  void perform() => print('Performing...');
}

mixin Musical on Performer {
  void playMusic() {
    perform(); // Can access Performer methods
    print('Playing music...');
  }
}

class Musician extends Performer with Musical {
  String name;
  Musician(this.name);
}

// --- Practical Example ---

abstract class Widget {
  void build();
}

class Button extends Widget {
  String label;

  Button(this.label);

  @override
  void build() {
    print('Building button: [$label]');
  }
}

class TextField extends Widget {
  String hint;

  TextField(this.hint);

  @override
  void build() {
    print('Building text field: |$hint|');
  }
}

// --- Combining Patterns ---

abstract class MediaPlayer {
  void play(String file);
  void pause();
}

mixin VolumeControl {
  double _volume = 0.5;

  void adjustVolume(double level) {
    _volume = level.clamp(0.0, 1.0);
    print('Volume set to $_volume');
  }
}

mixin Logging {
  void log(String message) => print('[LOG] $message');
}

class MusicPlayer extends MediaPlayer with VolumeControl, Logging {
  @override
  void play(String file) {
    log('Playing $file');
    print('Now playing: $file');
  }

  @override
  void pause() {
    log('Paused');
    print('Playback paused');
  }
}

// --- Sealed-like Pattern (Result type) ---

abstract class Result<T> {}

class Success<T> extends Result<T> {
  T value;
  Success(this.value);
}

class Failure<T> extends Result<T> {
  String error;
  Failure(this.error);
}

Result<String> fetchData(bool success) {
  if (success) {
    return Success('Data loaded');
  } else {
    return Failure('Failed to load');
  }
}

void handleResult(Result<String> result) {
  if (result is Success<String>) {
    print('Success: ${result.value}');
  } else if (result is Failure<String>) {
    print('Error: ${result.error}');
  }
}

// --- Type Alias ---

typedef UserId = String;
typedef UserMap = Map<String, dynamic>;
