// 01_conditionals.dart
// Run with: dart run 01_conditionals.dart

void main() {
  // --- Simple if Statement ---
  print('=== Simple if Statement ===');

  int temperature = 35;
  print('Temperature: $temperature°C');

  if (temperature > 30) {
    print('It is hot outside');
  }

  if (temperature > 40) {
    print('It is extremely hot'); // This won't print
  }

  // --- if-else Statement ---
  print('\n=== if-else Statement ===');

  int age = 16;
  print('Age: $age');

  if (age >= 18) {
    print('You can vote');
  } else {
    print('You cannot vote yet');
  }

  // --- if-else if-else Chain ---
  print('\n=== if-else if-else Chain ===');

  int score = 75;
  print('Score: $score');

  String grade;
  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else if (score >= 60) {
    grade = 'D';
  } else {
    grade = 'F';
  }
  print('Grade: $grade');

  // --- Order Matters ---
  print('\n=== Order Matters ===');

  int value = 95;
  print('Value: $value');

  // Wrong order — always matches the first condition
  if (value >= 60) {
    print('Wrong order: Matched >= 60');
  } else if (value >= 90) {
    print('This never prints for 95');
  }

  // Correct order — most specific first
  if (value >= 90) {
    print('Correct order: Matched >= 90');
  } else if (value >= 60) {
    print('This would print for 75');
  }

  // --- Nested Conditionals ---
  print('\n=== Nested Conditionals ===');

  bool isLoggedIn = true;
  bool isAdmin = false;
  bool isPremium = true;

  print('isLoggedIn: $isLoggedIn, isAdmin: $isAdmin, isPremium: $isPremium');

  if (isLoggedIn) {
    print('User is logged in');
    if (isAdmin) {
      print('  Access level: Administrator');
    } else if (isPremium) {
      print('  Access level: Premium User');
    } else {
      print('  Access level: Standard User');
    }
  } else {
    print('Please log in first');
  }

  // --- Combining Conditions ---
  print('\n=== Combining Conditions ===');

  int userAge = 25;
  bool hasLicense = true;
  bool hasCar = false;

  print('Age: $userAge, Has license: $hasLicense, Has car: $hasCar');

  // AND: both must be true
  if (userAge >= 18 && hasLicense) {
    print('Can legally drive');
  }

  // OR: at least one must be true
  if (hasLicense || hasCar) {
    print('Has at least a license or a car');
  }

  // Complex condition
  if (userAge >= 18 && hasLicense && !hasCar) {
    print('Can drive but needs to borrow a car');
  }

  // --- Ternary Operator ---
  print('\n=== Ternary Operator ===');

  int points = 150;
  print('Points: $points');

  // Ternary: condition ? valueIfTrue : valueIfFalse
  String level = points >= 100 ? 'Gold' : 'Silver';
  print('Level: $level');

  // Equivalent if-else:
  // String level;
  // if (points >= 100) {
  //   level = 'Gold';
  // } else {
  //   level = 'Silver';
  // }

  // Nested ternary (use sparingly)
  String tier = points >= 200
      ? 'Platinum'
      : points >= 100
          ? 'Gold'
          : 'Silver';
  print('Tier: $tier');

  // --- Null-aware Conditionals ---
  print('\n=== Null-aware Conditionals ===');

  String? userName;
  print('userName: $userName');

  // Check for null
  if (userName != null) {
    print('Hello, $userName');
  } else {
    print('Hello, Guest');
  }

  // Using ?? operator
  String displayName = userName ?? 'Guest';
  print('Display name: $displayName');

  // Assign a value
  userName = 'Alice';
  displayName = userName ?? 'Guest';
  print('After assignment: $displayName');
}
