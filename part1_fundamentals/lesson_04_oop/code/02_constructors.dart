// 02_constructors.dart
// Run with: dart run 02_constructors.dart

void main() {
  // --- Standard Constructor ---
  print('=== Standard Constructor ===');

  var point1 = Point(3, 4);
  print('Point1: $point1');

  // --- Named Constructors ---
  print('\n=== Named Constructors ===');

  var origin = Point.origin();
  print('Origin: $origin');

  var fromJson = Point.fromJson({'x': 5.0, 'y': 6.0});
  print('From JSON: $fromJson');

  var fromList = Point.fromList([7, 8]);
  print('From List: $fromList');

  // --- Optional and Named Parameters ---
  print('\n=== Optional Parameters ===');

  var user1 = User('alice@example.com');
  print('User1: $user1');

  var user2 = User('bob@example.com', name: 'Bob', age: 25);
  print('User2: $user2');

  var user3 = User('charlie@example.com', age: 30);
  print('User3: $user3');

  // --- Initializer Lists ---
  print('\n=== Initializer Lists ===');

  var rect = Rectangle(10, 5);
  print('Rectangle: ${rect.width}x${rect.height}');
  print('Area: ${rect.area}');
  print('Description: ${rect.description}');

  // --- Const Constructors ---
  print('\n=== Const Constructors ===');

  // Compile-time constants
  const c1 = ImmutablePoint(1, 2);
  const c2 = ImmutablePoint(1, 2);

  print('c1: $c1');
  print('c2: $c2');
  print('c1 == c2: ${c1 == c2}');
  print('identical(c1, c2): ${identical(c1, c2)}'); // true - same instance

  // Non-const instantiation
  var c3 = ImmutablePoint(1, 2);
  print('identical(c1, c3): ${identical(c1, c3)}'); // false - different instance

  // --- Factory Constructors ---
  print('\n=== Factory Constructors ===');

  // Singleton pattern
  var logger1 = Logger();
  var logger2 = Logger();

  print('logger1 == logger2: ${identical(logger1, logger2)}'); // true

  logger1.log('Hello from logger1');
  logger2.log('Hello from logger2');

  // Factory returning subtype
  var circle = Shape.create('circle', 5);
  var rectangle = Shape.create('rectangle', 10, 5);

  print('\nCircle area: ${circle?.area()}');
  print('Rectangle area: ${rectangle?.area()}');

  // --- Redirecting Constructors ---
  print('\n=== Redirecting Constructors ===');

  var p1 = Point3D(1, 2, 3);
  print('3D Point: $p1');

  var p2 = Point3D.xy(4, 5);
  print('3D Point from XY: $p2');

  var p3 = Point3D.origin();
  print('3D Origin: $p3');

  // --- Late Initialization ---
  print('\n=== Late Initialization ===');

  var config = Configuration();
  config.setup('MyApp', 'v1.0.0');
  print('Config: ${config.appName} ${config.version}');

  // --- Private Constructors ---
  print('\n=== Private Constructors ===');

  // Can't do: var db = Database();  // Private constructor

  // Must use the factory
  var db1 = Database.instance;
  var db2 = Database.instance;

  print('Same instance: ${identical(db1, db2)}');
  db1.query('SELECT * FROM users');

  // --- Copying Objects ---
  print('\n=== Copying with copyWith ===');

  var original = Person('Alice', 30, 'New York');
  print('Original: $original');

  var updated = original.copyWith(age: 31);
  print('Updated age: $updated');

  var moved = original.copyWith(city: 'Boston');
  print('Moved: $moved');

  var newPerson = original.copyWith(name: 'Alicia', age: 25, city: 'Miami');
  print('New person: $newPerson');
}

// --- Class Definitions ---

class Point {
  final double x;
  final double y;

  // Standard constructor with shorthand initialization
  Point(this.x, this.y);

  // Named constructor: creates origin point
  Point.origin()
      : x = 0,
        y = 0;

  // Named constructor: from JSON
  Point.fromJson(Map<String, double> json)
      : x = json['x'] ?? 0,
        y = json['y'] ?? 0;

  // Named constructor: from list
  Point.fromList(List<num> coords)
      : x = coords[0].toDouble(),
        y = coords[1].toDouble();

  @override
  String toString() => 'Point($x, $y)';
}

class User {
  final String email;
  final String? name;
  final int age;

  // Required parameter with optional named parameters
  User(this.email, {this.name, this.age = 0});

  @override
  String toString() =>
      'User(email: $email, name: ${name ?? 'N/A'}, age: $age)';
}

class Rectangle {
  final double width;
  final double height;
  final double area;
  final String description;

  // Initializer list: computed before constructor body runs
  Rectangle(this.width, this.height)
      : area = width * height,
        description = 'Rectangle ${width}x$height' {
    // Constructor body (optional)
    print('Created rectangle with area $area');
  }
}

class ImmutablePoint {
  final double x;
  final double y;

  // Const constructor: all fields must be final
  const ImmutablePoint(this.x, this.y);

  @override
  String toString() => 'ImmutablePoint($x, $y)';
}

class Logger {
  // Private instance
  static final Logger _instance = Logger._internal();

  // Factory constructor returns existing instance
  factory Logger() {
    return _instance;
  }

  // Private named constructor
  Logger._internal();

  void log(String message) {
    print('[LOG] $message');
  }
}

// Abstract class with factory
abstract class Shape {
  double area();

  // Factory that returns different subclasses
  factory Shape.create(String type, double a, [double? b]) {
    switch (type) {
      case 'circle':
        return CircleShape(a);
      case 'rectangle':
        return RectangleShape(a, b ?? a);
      default:
        throw ArgumentError('Unknown shape type: $type');
    }
  }
}

class CircleShape implements Shape {
  final double radius;

  CircleShape(this.radius);

  @override
  double area() => 3.14159 * radius * radius;
}

class RectangleShape implements Shape {
  final double width;
  final double height;

  RectangleShape(this.width, this.height);

  @override
  double area() => width * height;
}

class Point3D {
  final double x;
  final double y;
  final double z;

  Point3D(this.x, this.y, this.z);

  // Redirecting constructor: calls another constructor
  Point3D.xy(double x, double y) : this(x, y, 0);

  Point3D.origin() : this(0, 0, 0);

  @override
  String toString() => 'Point3D($x, $y, $z)';
}

class Configuration {
  // Late: will be initialized later, before first use
  late String appName;
  late String version;

  void setup(String name, String ver) {
    appName = name;
    version = ver;
  }
}

class Database {
  static final Database _instance = Database._internal();

  // Private constructor - can't be called from outside
  Database._internal();

  // Getter to access the singleton
  static Database get instance => _instance;

  void query(String sql) {
    print('Executing: $sql');
  }
}

class Person {
  final String name;
  final int age;
  final String city;

  Person(this.name, this.age, this.city);

  // copyWith pattern for immutable updates
  Person copyWith({String? name, int? age, String? city}) {
    return Person(
      name ?? this.name,
      age ?? this.age,
      city ?? this.city,
    );
  }

  @override
  String toString() => 'Person($name, $age, $city)';
}
