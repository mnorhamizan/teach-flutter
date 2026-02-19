# Flutter Fundamentals Course

A beginner-friendly Flutter course covering Dart programming and mobile app development. Students progress from language basics to building a complete Todo application.

## Course Structure

```
├── 00_prerequisites/          # Environment setup guide
├── part1_fundamentals/        # Lessons 1-6: Dart & Flutter basics
│   ├── lesson_01_dart_basics/
│   ├── lesson_02_control_flow/
│   ├── lesson_03_functions_collections/
│   ├── lesson_04_oop/
│   ├── lesson_05_widgets/
│   └── lesson_06_layouts_navigation/
└── part2_todo_app/            # Lessons 7-10: Building a complete app
    ├── lesson_07_app_structure/
    ├── lesson_08_state_management/
    ├── lesson_09_forms_validation/
    └── lesson_10_persistence/
```

## Prerequisites

- Basic programming experience in any language
- Computer running Windows 10+ or macOS 10.15+
- Minimum 8GB RAM recommended

See `00_prerequisites/00_prerequisites.md` for detailed setup instructions.

## Running the Code

### Dart files (Lessons 1-4)

```bash
cd part1_fundamentals/lesson_01_dart_basics/code
dart run 01_variables.dart
```

### Flutter projects (Lessons 5-10)

```bash
cd part1_fundamentals/lesson_05_widgets/widget_playground
flutter pub get
flutter run
```

## Lesson Overview

| Lesson | Topic | What You'll Learn |
|--------|-------|-------------------|
| 1 | Dart Basics | Variables, types, null safety, operators |
| 2 | Control Flow | Conditionals, loops, switch statements |
| 3 | Functions & Collections | Functions, List, Map, Set |
| 4 | OOP | Classes, inheritance, abstract classes, mixins |
| 5 | Flutter Widgets | StatelessWidget, StatefulWidget, widget tree |
| 6 | Layouts & Navigation | Layout widgets, ListView, Navigator |
| 7 | App Structure | Project organization, models, basic UI |
| 8 | State Management | setState, managing app state |
| 9 | Forms & Validation | User input, form validation |
| 10 | Persistence | Saving data with SharedPreferences |

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/language)
- [DartPad](https://dartpad.dev/) - Online Dart editor
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
