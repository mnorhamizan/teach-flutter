// 02_lists.dart
// Run with: dart run 02_lists.dart

void main() {
  // --- Creating Lists ---
  print('=== Creating Lists ===');

  // Type inference
  var fruits = ['apple', 'banana', 'cherry'];
  print('Fruits: $fruits');

  // Explicit type
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Numbers: $numbers');

  // Empty list
  List<String> emptyList = [];
  var anotherEmpty = <double>[];
  print('Empty list: $emptyList');

  // Fixed-length list
  var fixedList = List<int>.filled(5, 0);
  print('Fixed list (5 zeros): $fixedList');

  // Generate list
  var generated = List<int>.generate(5, (i) => i * 2);
  print('Generated (0, 2, 4, 6, 8): $generated');

  // --- Accessing Elements ---
  print('\n=== Accessing Elements ===');

  var colors = ['red', 'green', 'blue', 'yellow', 'purple'];
  print('Colors: $colors');

  print('First element [0]: ${colors[0]}');
  print('Third element [2]: ${colors[2]}');
  print('Last element [${colors.length - 1}]: ${colors[colors.length - 1]}');

  print('Using .first: ${colors.first}');
  print('Using .last: ${colors.last}');
  print('Length: ${colors.length}');

  // --- Modifying Lists ---
  print('\n=== Adding Elements ===');

  var items = ['a', 'b', 'c'];
  print('Initial: $items');

  items.add('d');
  print('After add("d"): $items');

  items.addAll(['e', 'f']);
  print('After addAll(["e", "f"]): $items');

  items.insert(0, 'z');
  print('After insert(0, "z"): $items');

  items.insertAll(2, ['x', 'y']);
  print('After insertAll(2, ["x", "y"]): $items');

  print('\n=== Removing Elements ===');

  var letters = ['a', 'b', 'c', 'd', 'e', 'f'];
  print('Initial: $letters');

  letters.remove('c');
  print('After remove("c"): $letters');

  letters.removeAt(0);
  print('After removeAt(0): $letters');

  letters.removeLast();
  print('After removeLast(): $letters');

  letters = ['a', 'b', 'c', 'd', 'e'];
  letters.removeRange(1, 3); // Remove index 1 and 2
  print('After removeRange(1, 3): $letters');

  letters = ['a', 'b', 'c', 'b', 'd', 'b'];
  letters.removeWhere((item) => item == 'b');
  print('After removeWhere(== "b"): $letters');

  // --- Updating Elements ---
  print('\n=== Updating Elements ===');

  var scores = [10, 20, 30, 40, 50];
  print('Initial: $scores');

  scores[2] = 35;
  print('After scores[2] = 35: $scores');

  scores.fillRange(0, 2, 99);
  print('After fillRange(0, 2, 99): $scores');

  // --- List Properties ---
  print('\n=== List Properties ===');

  var data = [1, 2, 3];
  print('List: $data');
  print('isEmpty: ${data.isEmpty}');
  print('isNotEmpty: ${data.isNotEmpty}');
  print('length: ${data.length}');

  var emptyData = <int>[];
  print('\nEmpty list isEmpty: ${emptyData.isEmpty}');

  // --- Searching ---
  print('\n=== Searching ===');

  var nums = [10, 20, 30, 20, 40];
  print('List: $nums');

  print('contains(20): ${nums.contains(20)}');
  print('contains(50): ${nums.contains(50)}');
  print('indexOf(20): ${nums.indexOf(20)}');
  print('lastIndexOf(20): ${nums.lastIndexOf(20)}');
  print('indexOf(50): ${nums.indexOf(50)}'); // -1 if not found

  // --- Sorting ---
  print('\n=== Sorting ===');

  var unsorted = [5, 2, 8, 1, 9, 3];
  print('Unsorted: $unsorted');

  unsorted.sort();
  print('After sort(): $unsorted');

  // Sort descending
  unsorted.sort((a, b) => b.compareTo(a));
  print('Sorted descending: $unsorted');

  // Sort strings
  var words = ['banana', 'Apple', 'cherry'];
  words.sort();
  print('Sorted words: $words'); // Case-sensitive

  words.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  print('Sorted case-insensitive: $words');

  // --- Reversing ---
  print('\n=== Reversing ===');

  var original = [1, 2, 3, 4, 5];
  print('Original: $original');

  var reversed = original.reversed.toList();
  print('Reversed (new list): $reversed');
  print('Original unchanged: $original');

  // --- Sublists ---
  print('\n=== Sublists ===');

  var list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  print('Full list: $list');

  print('sublist(2, 5): ${list.sublist(2, 5)}'); // [2, 3, 4]
  print('sublist(5): ${list.sublist(5)}'); // [5, 6, 7, 8, 9]
  print('getRange(2, 5): ${list.getRange(2, 5).toList()}');

  // --- Transformations ---
  print('\n=== Transformations ===');

  var values = [1, 2, 3, 4, 5];
  print('Original: $values');

  // map: transform each element
  var doubled = values.map((n) => n * 2).toList();
  print('Doubled: $doubled');

  var asStrings = values.map((n) => 'Item $n').toList();
  print('As strings: $asStrings');

  // where: filter elements
  var evens = values.where((n) => n % 2 == 0).toList();
  print('Evens: $evens');

  var greaterThan3 = values.where((n) => n > 3).toList();
  print('Greater than 3: $greaterThan3');

  // --- Reduction Operations ---
  print('\n=== Reduction ===');

  var nums2 = [1, 2, 3, 4, 5];
  print('List: $nums2');

  // reduce: combine all elements
  var sum = nums2.reduce((a, b) => a + b);
  print('Sum (reduce): $sum');

  var product = nums2.reduce((a, b) => a * b);
  print('Product (reduce): $product');

  // fold: like reduce but with initial value
  var sumWithInitial = nums2.fold(10, (sum, n) => sum + n);
  print('Sum starting from 10: $sumWithInitial');

  // --- Checking Conditions ---
  print('\n=== Checking Conditions ===');

  var testNums = [2, 4, 6, 8, 10];
  print('List: $testNums');

  print('any odd: ${testNums.any((n) => n % 2 != 0)}');
  print('any > 5: ${testNums.any((n) => n > 5)}');
  print('every even: ${testNums.every((n) => n % 2 == 0)}');
  print('every < 20: ${testNums.every((n) => n < 20)}');

  // --- Spread Operator ---
  print('\n=== Spread Operator ===');

  var list1 = [1, 2, 3];
  var list2 = [4, 5, 6];

  var combined = [...list1, ...list2];
  print('Combined: $combined');

  var withExtras = [0, ...list1, 100];
  print('With extras: $withExtras');

  // Null-aware spread
  List<int>? maybeNull;
  var safeSpread = [1, 2, ...?maybeNull, 3];
  print('Safe spread (null list): $safeSpread');

  // --- Collection If and For ---
  print('\n=== Collection If/For ===');

  bool includeExtra = true;
  var conditional = [
    'always',
    if (includeExtra) 'sometimes',
    'always too',
  ];
  print('Conditional (includeExtra=true): $conditional');

  var squares = [
    for (var i = 1; i <= 5; i++) i * i,
  ];
  print('Squares 1-5: $squares');
}
