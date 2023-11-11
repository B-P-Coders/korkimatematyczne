/// In urder to make requests use `Journal` class to get
/// necessary indexes, and images
/// You should get this data in specified order:
/// `BookIndex` -> `Subindex` -> `LessonIndex` -> .tasks -> .link -> getImages(link)
/// For more infromation look at examples
library;

export 'src/models.dart';
export 'src/journal.dart';
