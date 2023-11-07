import 'package:embed_annotation/embed_annotation.dart';
import 'book_index.dart';

part 'journal.g.dart';

@EmbedLiteral("./journal.json")
const List<Map<String, String>> bookIdx = _$bookIdx;

class Journal {
  late List<BookIndex> availableBooks;

  Journal() {
    availableBooks = bookIdx.map((e) => BookIndex.fromMap(e)).toList();
  }

  Subindex getSubIndex(int bookIdx) {
    return availableBooks[bookIdx].getSubindex();
  }

  Subindex getSubIndexbyName(String name) {
    for (final e in availableBooks) {
      if (e.name == name) return e.getSubindex();
    }
    throw JournalException("Book Index named $name not found");
  }
}

class JournalException implements Exception {
  late String cause;
  JournalException(String c) {
    cause = "Journal exception: $c";
  }
}
