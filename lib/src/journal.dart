import 'package:embed_annotation/embed_annotation.dart';
import 'models.dart';
import 'scraper.dart';

part 'journal.g.dart';

@EmbedLiteral("./journal.json")
const List<Map<String, String>> bookIdx = _$bookIdx;

class Journal {
  late List<BookIndex> availableBooks;
  late Scraper _scraper;

  Journal() {
    availableBooks = bookIdx.map((e) => BookIndex.fromMap(e)).toList();
  }

  Future<List<Subindex>> getSubindex(int idx) async {
    return await _scraper.getSubindexes(availableBooks[idx].index);
  }

  Future<List<Subindex>> getSubindexesbyName(String name) async {
    for (final (i, e) in availableBooks.indexed) {
      if (e.name == name) return await getSubindex(i);
    }
    throw JournalException("Book Index named $name not found");
  }

  Future<List<LessonIndex>> getLessonIndexes(Subindex sb) async {
    return await _scraper.getLessonIndexes(sb.index);
  }

  Future<List<String>> getImagesForTask(LessonIndex li, int idx) async {
    return await _scraper.getImages((await li.tasks)[idx].link);
  }

  Future<List<String>> getImageForTaskByName(
      LessonIndex li, String name) async {
    for (final (i, e) in (await li.tasks).indexed) {
      if (e.name == name) return await getImagesForTask(li, i);
    }
    throw JournalException(
        "Task named $name not found in lesson index ${li.name}");
  }
}

class JournalException implements Exception {
  late String cause;
  JournalException(String c) {
    cause = "Journal exception: $c";
  }
}
