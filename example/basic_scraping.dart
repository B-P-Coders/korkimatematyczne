import 'package:korkimatematyczne/korkimatematyczne.dart';

void main() async {
  print("Getting first task in first book in first lesson...\n");
  final journal = Journal();

  final subindex =
      (await journal.getSubindexes(0))[0]; // book index 0, subindex 0

  final lessonindex =
      (await journal.getLessonIndexes(subindex))[0]; // lesson index 0

  final task = (await lessonindex.tasks)[0]; // task index 0
  print("Task ${task.name} is awailable at link ${task.link}\n");

  final imgs = (await journal.getImagesForTask(task));
  print("Images: ${imgs.join(", ")}");
}
