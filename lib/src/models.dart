class BookIndex {
  late String name;
  late String index;

  BookIndex(this.name, this.index);

  BookIndex.fromMap(Map<String, String> json) {
    name = json["name"]!;
    index = json["index"]!;
  }
}

class Subindex {
  late String name;
  late String index;

  Subindex(this.name, this.index);
}

class LessonIndex {
  late String name;
  late String link;

  // Task list requires a lot of requests
  late Future<List<Task>> tasks;

  LessonIndex(this.name, this.link);
}

class Task {
  late String name;
  late String link;

  Task(this.name, this.link);
}
