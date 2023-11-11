/// A singe book entry in list of supported math books
class BookIndex {
  late String name;
  late String index;

  BookIndex(this.name, this.index);

  BookIndex.fromMap(Map<String, String> json) {
    name = json["name"]!;
    index = json["index"]!;
  }
}

/// A single chapter inside a maths book
class Subindex {
  late String name;
  late String index;

  Subindex(this.name, this.index);
}

/// A single lesson inside a chapter
/// contains a list of `Task`s
class LessonIndex {
  late String name;
  late String link;

  // Task list requires a lot of requests
  late Future<List<Task>> tasks;

  LessonIndex(this.name, this.link);
}

/// A single task inside a lesson
class Task {
  late String name;
  late String link;

  Task(this.name, this.link);
}
