import 'package:embed_annotation/embed_annotation.dart';
import 'models.dart';
import 'scraper.dart';

part 'journal.g.dart';

/// Embedded data from static index in journal.json file
/// using the `embed` lib
@EmbedLiteral("./journal.json")
const List<Map<String, String>> bookIdx = _$bookIdx;

/// `Journal` gets information form korkimatematyczne.blogsport.com,
/// including indexes and images, stores list ofbookIndex
/// and controlls `Scraper`
class Journal {
  late List<BookIndex> availableBooks;
  late Scraper _scraper;

  Journal() {
    availableBooks = bookIdx.map((e) => BookIndex.fromMap(e)).toList();
    _scraper = Scraper();
  }

  /// Gets list of `Subindex`es for specified index in list
  Future<List<Subindex>> getSubindex(int idx) async {
    return await _scraper.getSubindexes(availableBooks[idx].index);
  }

  /// Gets list of `Subindex`es for specified name
  Future<List<Subindex>> getSubindexesbyName(String name) async {
    for (final (i, e) in availableBooks.indexed) {
      if (e.name == name) return await getSubindex(i);
    }
    throw JournalException("Book Index named $name not found");
  }

  /// Gets list of `LessonIndex`es for specified `Subindex`
  Future<List<LessonIndex>> getLessonIndexes(Subindex sb) async {
    return await _scraper.getLessonIndexes(sb.index);
  }

  /// Gets list of image links for specified `LessonIndex` and `Task` index
  Future<List<String>> getImagesForLessonAndIdx(LessonIndex li, int idx) async {
    return await _scraper.getImages((await li.tasks)[idx].link);
  }

  /// Gets list of image links for specified `Task`
  Future<List<String>> getImagesForTask(Task task) async {
    return await _scraper.getImages(task.link);
  }

  /// Gets list of image links for specified `LessonIndex` and `Task` name
  Future<List<String>> getImageForTaskByName(
      LessonIndex li, String name) async {
    for (final (i, e) in (await li.tasks).indexed) {
      if (e.name == name) return await getImagesForLessonAndIdx(li, i);
    }
    throw JournalException(
        "Task named $name not found in lesson index ${li.name}");
  }
}

/// Exception type for errors connected with `Journal`
class JournalException implements Exception {
  late String cause;
  JournalException(String c) {
    cause = "Journal exception: $c";
  }
}
