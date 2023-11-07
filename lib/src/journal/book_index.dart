class BookIndex {
  late String name;
  late String index;

  BookIndex(this.name, this.index);

  BookIndex.fromMap(Map<String, String> json) {
    name = json["name"]!;
    index = json["index"]!;
  }

  getSubindex() {
    // TODO: get subindex for current book
  }
}

class Subindex {} // TODO: implement subindex

class LessonIndex {} // TODO: implemet lesson index

// TODO: individual task scraping 
