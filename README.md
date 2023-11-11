# korkimatematyczne

A library used to scrape korkimatematyczne.blogspot.com website

---

## Getting Started

In your `pubspec.yml` put:

```yaml
dependencies:
  korkimatematyczne:
    git:
      url: https://github.com/B-P-Coders/korkimatematyczne.git
      ref: main
```

then

```dart
import 'package:korkimatematyczne/korkimatematyczne.dart';
```

## Usage

```dart
  print("Getting first task in first book in first lesson...\n");
  final journal = Journal();

  final subindex = (await journal.getSubindexes(0))[0]; // book index 0, subindex 0

  final lessonindex = (await journal.getLessonIndexes(subindex))[0]; // lesson index 0

  final task = (await lessonindex.tasks)[0]; // task index 0
  print("Task ${task.name} is awailable at link ${task.link}\n");

  final imgs = (await journal.getImagesForTask(task));
  print("Images: ${imgs.join(", ")}");
```

## Regenerating index

After changing `journal.json` file you should also rebuild `journal.g.dart` using this command

```bash
dart run build_runner build
```

