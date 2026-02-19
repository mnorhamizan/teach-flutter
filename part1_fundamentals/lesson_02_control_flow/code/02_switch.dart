// 02_switch.dart
// Run with: dart run 02_switch.dart

void main() {
  // --- Basic Switch Statement ---
  print('=== Basic Switch Statement ===');

  String day = 'Wednesday';
  print('Day: $day');

  switch (day) {
    case 'Monday':
      print('Start of work week');
      break;
    case 'Tuesday':
      print('Second day');
      break;
    case 'Wednesday':
      print('Midweek');
      break;
    case 'Thursday':
      print('Almost Friday');
      break;
    case 'Friday':
      print('End of work week');
      break;
    case 'Saturday':
      print('Weekend!');
      break;
    case 'Sunday':
      print('Rest day');
      break;
    default:
      print('Invalid day');
  }

  // --- Multiple Cases (Fall-through) ---
  print('\n=== Multiple Cases ===');

  String dayType;
  switch (day) {
    case 'Monday':
    case 'Tuesday':
    case 'Wednesday':
    case 'Thursday':
    case 'Friday':
      dayType = 'Weekday';
      break;
    case 'Saturday':
    case 'Sunday':
      dayType = 'Weekend';
      break;
    default:
      dayType = 'Unknown';
  }
  print('$day is a $dayType');

  // --- Switch with Numbers ---
  print('\n=== Switch with Numbers ===');

  int month = 4;
  print('Month number: $month');

  String monthName;
  switch (month) {
    case 1:
      monthName = 'January';
      break;
    case 2:
      monthName = 'February';
      break;
    case 3:
      monthName = 'March';
      break;
    case 4:
      monthName = 'April';
      break;
    case 5:
      monthName = 'May';
      break;
    case 6:
      monthName = 'June';
      break;
    case 7:
      monthName = 'July';
      break;
    case 8:
      monthName = 'August';
      break;
    case 9:
      monthName = 'September';
      break;
    case 10:
      monthName = 'October';
      break;
    case 11:
      monthName = 'November';
      break;
    case 12:
      monthName = 'December';
      break;
    default:
      monthName = 'Invalid month';
  }
  print('Month name: $monthName');

  // --- Switch Expression (Dart 3+) ---
  print('\n=== Switch Expression ===');

  // More concise syntax that returns a value
  String command = 'start';
  print('Command: $command');

  String action = switch (command) {
    'start' => 'Starting the system...',
    'stop' => 'Stopping the system...',
    'restart' => 'Restarting the system...',
    'status' => 'System is running',
    _ => 'Unknown command' // _ is the default case
  };
  print('Action: $action');

  // --- Switch Expression with Multiple Patterns ---
  print('\n=== Switch Expression with Multiple Patterns ===');

  String fruit = 'apple';
  print('Fruit: $fruit');

  String color = switch (fruit) {
    'apple' || 'cherry' || 'strawberry' => 'red',
    'banana' || 'lemon' => 'yellow',
    'orange' || 'mango' => 'orange',
    'grape' || 'plum' => 'purple',
    'lime' || 'kiwi' => 'green',
    _ => 'unknown'
  };
  print('Color: $color');

  // --- Enum with Switch ---
  print('\n=== Enum with Switch ===');

  Status status = Status.loading;
  print('Status: $status');

  // Switch on enum values
  String message;
  switch (status) {
    case Status.idle:
      message = 'Waiting for input';
      break;
    case Status.loading:
      message = 'Loading data...';
      break;
    case Status.success:
      message = 'Operation completed';
      break;
    case Status.error:
      message = 'Something went wrong';
      break;
  }
  print('Message: $message');

  // With switch expression
  String icon = switch (status) {
    Status.idle => '⏸️',
    Status.loading => '⏳',
    Status.success => '✅',
    Status.error => '❌',
  };
  print('Icon: $icon');

  // --- When Guards (Dart 3+) ---
  print('\n=== When Guards ===');

  int httpStatus = 404;
  print('HTTP Status: $httpStatus');

  String response = switch (httpStatus) {
    200 => 'OK',
    201 => 'Created',
    int code when code >= 400 && code < 500 => 'Client Error',
    int code when code >= 500 => 'Server Error',
    _ => 'Unknown Status'
  };
  print('Response: $response');

  // --- Practical Example: Calculator ---
  print('\n=== Calculator Example ===');

  int a = 10;
  int b = 3;
  String operation = '+';

  print('$a $operation $b = ?');

  num? result;
  switch (operation) {
    case '+':
      result = a + b;
      break;
    case '-':
      result = a - b;
      break;
    case '*':
      result = a * b;
      break;
    case '/':
      result = a / b;
      break;
    case '%':
      result = a % b;
      break;
    default:
      print('Unknown operation');
  }

  if (result != null) {
    print('Result: $result');
  }
}

// Enum for status example
enum Status { idle, loading, success, error }
