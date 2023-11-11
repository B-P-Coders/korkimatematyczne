import 'package:korkimatematyczne/korkimatematyczne.dart';
import 'dart:io';

void main() async {
  final journal = Journal();

  print("Choose book:");
  for (var (i, e) in journal.availableBooks.indexed) {
    print("${i + 1}. ${e.name}");
  }
  final bookNum = int.parse(stdin.readLineSync()!) - 1;

  final subindexes = await journal.getSubindexes(bookNum);
  print("Choose subindex:");
  for (var e in subindexes) {
    print(e.name);
  }
  final subindexNum = int.parse(stdin.readLineSync()!) - 1;

  final subindex = subindexes[subindexNum];
  final lessonIndexes = await journal.getLessonIndexes(subindex);
  print("Chooose lesson:");
  for (var e in lessonIndexes) {
    print(e.name);
  }
  final lessonNum = int.parse(stdin.readLineSync()!) - 1;

  final lessonindex = lessonIndexes[lessonNum];
  final tasks = await lessonindex.tasks;
  print("Choose task");
  for (var (i, e) in tasks.indexed) {
    print("${i + 1}. ${e.name}");
  }
  final taskNum = int.parse(stdin.readLineSync()!) - 1;

  final task = tasks[taskNum];
  print("Task ${task.name} is awailable at link ${task.link}\n");
  final imgs = (await journal.getImagesForTask(task));
  print("Images: ${imgs.join(", ")}");
}
