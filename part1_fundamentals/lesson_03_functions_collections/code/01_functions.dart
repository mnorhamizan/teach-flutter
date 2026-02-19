// 01_functions.dart
// Run with: dart run 01_functions.dart

void main() {
  // --- Basic Function ---
  print('=== Basic Function ===');

  greet(); // Call the function

  // --- Function with Return Value ---
  print('\n=== Function with Return Value ===');

  int sum = add(5, 3);
  print('5 + 3 = $sum');

  // Using return value directly
  print('10 + 20 = ${add(10, 20)}');

  // --- Function with Parameters ---
  print('\n=== Function with Parameters ===');

  greetPerson('Alice');
  greetPerson('Bob');

  // --- Optional Positional Parameters ---
  print('\n=== Optional Positional Parameters ===');

  // Uses default greeting
  greetWithOptional('Alice');
  // Uses provided greeting
  greetWithOptional('Bob', 'Welcome');
  // Uses both optional parameters
  greetWithOptionalPunctuation('Charlie', 'Hi', '!!!');

  // --- Named Parameters ---
  print('\n=== Named Parameters ===');

  // Only required parameter
  createUser(name: 'Alice');
  // With optional parameters
  createUser(name: 'Bob', age: 25);
  // Parameters in any order
  createUser(email: 'charlie@example.com', age: 30, name: 'Charlie');

  // --- Default Parameter Values ---
  print('\n=== Default Parameter Values ===');

  connect('example.com');
  connect('secure.example.com', port: 443, secure: true);

  // --- Arrow Functions ---
  print('\n=== Arrow Functions ===');

  print('multiply(4, 5) = ${multiply(4, 5)}');
  print('square(7) = ${square(7)}');
  print('isEven(4) = ${isEven(4)}');
  print('isEven(7) = ${isEven(7)}');

  // --- Functions as First-Class Objects ---
  print('\n=== Functions as Values ===');

  // Store function in variable
  var mathOp = add;
  print('Using add: ${mathOp(10, 5)}');

  mathOp = subtract;
  print('Using subtract: ${mathOp(10, 5)}');

  // Pass function to another function
  print('calculate(10, 5, add) = ${calculate(10, 5, add)}');
  print('calculate(10, 5, multiply) = ${calculate(10, 5, multiply)}');

  // --- Anonymous Functions ---
  print('\n=== Anonymous Functions ===');

  // Anonymous function stored in variable
  var triple = (int x) {
    return x * 3;
  };
  print('triple(4) = ${triple(4)}');

  // Arrow syntax anonymous function
  var doubleIt = (int x) => x * 2;
  print('doubleIt(4) = ${doubleIt(4)}');

  // Anonymous function as callback
  var numbers = [1, 2, 3, 4, 5];
  print('\nNumbers doubled:');
  numbers.forEach((n) {
    print('  $n -> ${n * 2}');
  });

  // --- Closures ---
  print('\n=== Closures ===');

  // A closure captures variables from its surrounding scope
  var counter = makeCounter();
  print('Counter: ${counter()}'); // 1
  print('Counter: ${counter()}'); // 2
  print('Counter: ${counter()}'); // 3

  // Each call to makeCounter creates a new closure
  var anotherCounter = makeCounter();
  print('Another counter: ${anotherCounter()}'); // 1

  // --- Recursive Functions ---
  print('\n=== Recursive Functions ===');

  print('factorial(5) = ${factorial(5)}');
  print('fibonacci(10) = ${fibonacci(10)}');

  // --- Function Type Annotations ---
  print('\n=== Function Types ===');

  // Explicitly typed function variable
  int Function(int, int) operation = add;
  print('operation(8, 3) = ${operation(8, 3)}');

  // Function that returns a function
  var adder = makeAdder(10);
  print('adder(5) = ${adder(5)}'); // 15
  print('adder(20) = ${adder(20)}'); // 30
}

// --- Function Definitions ---

// Basic function: no parameters, no return value
void greet() {
  print('Hello, World!');
}

// Function with return value
int add(int a, int b) {
  return a + b;
}

int subtract(int a, int b) {
  return a - b;
}

// Function with required parameter
void greetPerson(String name) {
  print('Hello, $name!');
}

// Optional positional parameter with default value
void greetWithOptional(String name, [String greeting = 'Hello']) {
  print('$greeting, $name!');
}

// Multiple optional positional parameters
void greetWithOptionalPunctuation(String name,
    [String greeting = 'Hello', String punctuation = '!']) {
  print('$greeting, $name$punctuation');
}

// Named parameters (required and optional)
void createUser({required String name, int age = 0, String? email}) {
  print('User: $name, Age: $age, Email: ${email ?? 'not provided'}');
}

// Named parameters with defaults
void connect(String host, {int port = 80, bool secure = false}) {
  String protocol = secure ? 'https' : 'http';
  print('Connecting to $protocol://$host:$port');
}

// Arrow function (single expression)
int multiply(int a, int b) => a * b;

int square(int x) => x * x;

bool isEven(int n) => n % 2 == 0;

// Higher-order function: takes a function as parameter
int calculate(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

// Function that returns a function (closure)
Function makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

// Another function returning a function
int Function(int) makeAdder(int addend) {
  return (int value) => value + addend;
}

// Recursive function: factorial
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

// Recursive function: fibonacci
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
