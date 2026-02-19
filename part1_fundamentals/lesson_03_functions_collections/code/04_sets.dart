// 04_sets.dart
// Run with: dart run 04_sets.dart

void main() {
  // --- Creating Sets ---
  print('=== Creating Sets ===');

  // Type inference
  var fruits = {'apple', 'banana', 'cherry'};
  print('Fruits: $fruits');

  // Explicit type
  Set<int> numbers = {1, 2, 3, 4, 5};
  print('Numbers: $numbers');

  // Empty set (note: {} creates a Map, not a Set)
  Set<String> emptySet = {};
  var anotherEmpty = <int>{};
  print('Empty set: $emptySet');

  // From list
  var list = [1, 2, 2, 3, 3, 3, 4];
  var fromList = list.toSet();
  print('From list $list: $fromList');

  // From Set.from
  var fromAnother = Set<int>.from([5, 6, 7, 8]);
  print('Set.from: $fromAnother');

  // --- Uniqueness ---
  print('\n=== Uniqueness ===');

  var unique = <int>{};
  unique.add(1);
  unique.add(2);
  unique.add(2); // Duplicate, won't be added
  unique.add(3);
  unique.add(1); // Duplicate, won't be added

  print('After adding 1, 2, 2, 3, 1: $unique');
  print('Length: ${unique.length}'); // 3, not 5

  // --- Adding Elements ---
  print('\n=== Adding Elements ===');

  var colors = {'red', 'green'};
  print('Initial: $colors');

  // add returns true if element was added
  bool added = colors.add('blue');
  print('add("blue") returned $added: $colors');

  added = colors.add('red'); // Already exists
  print('add("red") returned $added: $colors');

  // addAll
  colors.addAll(['yellow', 'purple', 'red']);
  print('After addAll: $colors');

  // --- Removing Elements ---
  print('\n=== Removing Elements ===');

  var nums = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  print('Initial: $nums');

  // remove
  nums.remove(5);
  print('After remove(5): $nums');

  // removeWhere
  nums.removeWhere((n) => n % 2 == 0);
  print('After removeWhere(even): $nums');

  // retainWhere (opposite of removeWhere)
  nums = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  nums.retainWhere((n) => n <= 5);
  print('After retainWhere(<= 5): $nums');

  // clear
  var toClear = {1, 2, 3};
  toClear.clear();
  print('After clear: $toClear');

  // --- Checking Membership ---
  print('\n=== Checking Membership ===');

  var letters = {'a', 'b', 'c', 'd', 'e'};
  print('Set: $letters');

  print('contains("c"): ${letters.contains('c')}');
  print('contains("z"): ${letters.contains('z')}');
  print('containsAll({"a", "b"}): ${letters.containsAll({'a', 'b'})}');
  print('containsAll({"a", "z"}): ${letters.containsAll({'a', 'z'})}');

  // --- Set Properties ---
  print('\n=== Set Properties ===');

  var props = {1, 2, 3, 4, 5};
  print('Set: $props');

  print('length: ${props.length}');
  print('isEmpty: ${props.isEmpty}');
  print('isNotEmpty: ${props.isNotEmpty}');
  print('first: ${props.first}');
  print('last: ${props.last}');

  // --- Set Operations ---
  print('\n=== Set Operations ===');

  var a = {1, 2, 3, 4, 5};
  var b = {4, 5, 6, 7, 8};

  print('Set A: $a');
  print('Set B: $b');

  // Union: all elements from both sets
  var union = a.union(b);
  print('\nUnion (A ∪ B): $union');

  // Intersection: elements in both sets
  var intersection = a.intersection(b);
  print('Intersection (A ∩ B): $intersection');

  // Difference: elements in A but not in B
  var differenceAB = a.difference(b);
  print('Difference (A - B): $differenceAB');

  var differenceBA = b.difference(a);
  print('Difference (B - A): $differenceBA');

  // Symmetric difference (elements in either but not both)
  var symmetric = a.union(b).difference(a.intersection(b));
  print('Symmetric difference: $symmetric');

  // --- Practical: Removing Duplicates ---
  print('\n=== Removing Duplicates from List ===');

  var withDuplicates = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5];
  print('Original list: $withDuplicates');

  var uniqueList = withDuplicates.toSet().toList();
  print('After removing duplicates: $uniqueList');

  // Preserving order (toSet doesn't guarantee order)
  var orderedUnique = <int>[];
  var seen = <int>{};
  for (var item in withDuplicates) {
    if (seen.add(item)) {
      orderedUnique.add(item);
    }
  }
  print('Ordered unique: $orderedUnique');

  // --- Practical: Finding Common Elements ---
  print('\n=== Finding Common Elements ===');

  var list1 = ['apple', 'banana', 'cherry', 'date'];
  var list2 = ['banana', 'date', 'elderberry', 'fig'];

  var common = list1.toSet().intersection(list2.toSet());
  print('List 1: $list1');
  print('List 2: $list2');
  print('Common elements: $common');

  // --- Practical: Finding Unique Words ---
  print('\n=== Unique Words in Text ===');

  var text = 'The quick brown fox jumps over the lazy dog';
  var words = text.toLowerCase().split(' ').toSet();
  print('Text: "$text"');
  print('Unique words: $words');
  print('Count: ${words.length}');

  // --- Practical: Comparing Lists ---
  print('\n=== Comparing Lists ===');

  var team1 = {'Alice', 'Bob', 'Charlie', 'Diana'};
  var team2 = {'Charlie', 'Diana', 'Eve', 'Frank'};

  print('Team 1: $team1');
  print('Team 2: $team2');

  var onlyTeam1 = team1.difference(team2);
  print('Only in Team 1: $onlyTeam1');

  var onlyTeam2 = team2.difference(team1);
  print('Only in Team 2: $onlyTeam2');

  var inBoth = team1.intersection(team2);
  print('In both teams: $inBoth');

  var allMembers = team1.union(team2);
  print('All members: $allMembers');

  // --- Iterating ---
  print('\n=== Iterating ===');

  var items = {'one', 'two', 'three'};
  print('Set: $items');

  print('\nUsing for-in:');
  for (var item in items) {
    print('  $item');
  }

  print('\nUsing forEach:');
  items.forEach((item) => print('  $item'));

  // --- Converting ---
  print('\n=== Converting ===');

  var set = {3, 1, 4, 1, 5, 9, 2, 6};
  print('Set: $set');

  var asList = set.toList();
  print('As list: $asList');

  var sortedList = set.toList()..sort();
  print('As sorted list: $sortedList');

  // --- Lookup Performance ---
  print('\n=== Set vs List Lookup ===');

  // Sets have O(1) lookup, Lists have O(n)
  // For large collections, use Set when you need fast contains() checks

  var largeList = List.generate(10000, (i) => i);
  var largeSet = largeList.toSet();

  // Both work, but Set is faster for contains()
  print('List contains 9999: ${largeList.contains(9999)}');
  print('Set contains 9999: ${largeSet.contains(9999)}');
}
