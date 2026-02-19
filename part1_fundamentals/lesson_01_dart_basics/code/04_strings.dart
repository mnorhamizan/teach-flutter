// 04_strings.dart
// Run with: dart run 04_strings.dart

void main() {
  // --- Creating Strings ---
  print('=== Creating Strings ===');

  // Single or double quotes — both work the same
  String single = 'Hello with single quotes';
  String doubleQuoted = "Hello with double quotes";

  print(single);
  print(doubleQuoted);

  // Use one type to include the other without escaping
  String withApostrophe = "It's a nice day";
  String withQuote = 'She said "Hello"';

  print(withApostrophe);
  print(withQuote);

  // Escape characters when needed
  String escaped = 'It\'s also valid to escape';
  print(escaped);

  // --- String Interpolation ---
  print('\n=== String Interpolation ===');

  String name = 'Alice';
  int age = 30;
  double height = 1.75;

  // Simple variable: $variable
  print('Name: $name');
  print('Age: $age years');

  // Expressions: ${expression}
  print('Next year: ${age + 1}');
  print('Height in cm: ${height * 100}');
  print('Name uppercase: ${name.toUpperCase()}');

  // Without interpolation (string concatenation)
  String concatenated = 'Name: ' + name + ', Age: ' + age.toString();
  print('Concatenated: $concatenated');
  // Interpolation is usually cleaner

  // --- Multi-line Strings ---
  print('\n=== Multi-line Strings ===');

  String address = '''
123 Main Street
Apartment 4B
New York, NY 10001''';

  print('Address:');
  print(address);

  // Also works with double quotes
  String poem = """
Roses are red,
Violets are blue,
Dart is awesome,
And so are you.""";

  print('\nPoem:');
  print(poem);

  // --- Raw Strings ---
  print('\n=== Raw Strings ===');

  // Normal string: backslash has special meaning
  String normal = 'Line 1\nLine 2\tTabbed';
  print('Normal string:');
  print(normal);

  // Raw string: backslash is literal
  String raw = r'Line 1\nLine 2\tTabbed';
  print('\nRaw string:');
  print(raw);

  // Useful for regex or file paths
  String windowsPath = r'C:\Users\Alice\Documents';
  print('Windows path: $windowsPath');

  // --- String Properties ---
  print('\n=== String Properties ===');

  String text = 'Hello, World!';
  print('Text: "$text"');
  print('Length: ${text.length}');
  print('Is empty: ${text.isEmpty}');
  print('Is not empty: ${text.isNotEmpty}');

  String empty = '';
  print('\nEmpty string isEmpty: ${empty.isEmpty}');

  // --- String Methods ---
  print('\n=== String Methods ===');

  String sample = '  Flutter Development  ';
  print('Original: "$sample"');

  // Trimming whitespace
  print('trim(): "${sample.trim()}"');
  print('trimLeft(): "${sample.trimLeft()}"');
  print('trimRight(): "${sample.trimRight()}"');

  // Case conversion
  String greeting = 'Hello World';
  print('\nOriginal: "$greeting"');
  print('toUpperCase(): ${greeting.toUpperCase()}');
  print('toLowerCase(): ${greeting.toLowerCase()}');

  // Checking content
  print('\nContent checks on "$greeting":');
  print('contains("World"): ${greeting.contains('World')}');
  print('startsWith("Hello"): ${greeting.startsWith('Hello')}');
  print('endsWith("World"): ${greeting.endsWith('World')}');
  print('contains("Dart"): ${greeting.contains('Dart')}');

  // Finding and extracting
  print('\nFinding and extracting:');
  print('indexOf("o"): ${greeting.indexOf('o')}'); // 4 (first occurrence)
  print('lastIndexOf("o"): ${greeting.lastIndexOf('o')}'); // 7
  print('substring(0, 5): ${greeting.substring(0, 5)}'); // Hello
  print('substring(6): ${greeting.substring(6)}'); // World

  // Splitting
  print('\nSplitting:');
  String csv = 'apple,banana,cherry';
  List<String> fruits = csv.split(',');
  print('Split "$csv": $fruits');

  String sentence = 'The quick brown fox';
  List<String> words = sentence.split(' ');
  print('Words in "$sentence": $words');

  // Replacing
  print('\nReplacing:');
  String original = 'Hello World';
  print('replaceAll("o", "0"): ${original.replaceAll('o', '0')}');
  print('replaceFirst("l", "L"): ${original.replaceFirst('l', 'L')}');

  // --- Accessing Characters ---
  print('\n=== Accessing Characters ===');

  String word = 'Dart';
  print('Word: $word');

  // By index
  print('First character: ${word[0]}');
  print('Last character: ${word[word.length - 1]}');

  // Iterating over characters
  print('Characters:');
  for (int i = 0; i < word.length; i++) {
    print('  [$i]: ${word[i]}');
  }

  // --- String Comparison ---
  print('\n=== String Comparison ===');

  String s1 = 'apple';
  String s2 = 'Apple';
  String s3 = 'apple';

  print('"$s1" == "$s2": ${s1 == s2}'); // false (case-sensitive)
  print('"$s1" == "$s3": ${s1 == s3}'); // true
  print(
      '"$s1".toLowerCase() == "$s2".toLowerCase(): ${s1.toLowerCase() == s2.toLowerCase()}'); // true

  // compareTo for sorting
  print('\ncompareTo (for sorting):');
  print('"apple".compareTo("banana"): ${'apple'.compareTo('banana')}'); // negative
  print('"banana".compareTo("apple"): ${'banana'.compareTo('apple')}'); // positive
  print('"apple".compareTo("apple"): ${'apple'.compareTo('apple')}'); // 0

  // --- Padding ---
  print('\n=== Padding ===');

  String numStr = '42';
  print('Original: "$numStr"');
  print('padLeft(5): "${numStr.padLeft(5)}"'); // "   42"
  print('padLeft(5, "0"): "${numStr.padLeft(5, '0')}"'); // "00042"
  print('padRight(5): "${numStr.padRight(5)}"'); // "42   "
  print('padRight(5, "-"): "${numStr.padRight(5, '-')}"'); // "42---"
}
