// TODO: Get links from certain exercise
// TODO: Get list of exercises
class Journal {}

class JournalException implements Exception {
  late String cause;
  JournalException(String c) {
    cause = "Journal exception: $c";
  }
}
