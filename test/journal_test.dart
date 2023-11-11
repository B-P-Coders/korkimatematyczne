import 'package:korkimatematyczne/src/journal.dart';
import 'package:korkimatematyczne/src/models.dart';
import 'package:test/test.dart';

void main() {
  group('Scraper tests', () {
    late Journal myJournal;

    setUp(() {
      myJournal = Journal();
    });

    BookIndex myBook;
    Subindex mySubindex = Subindex("", "");
    LessonIndex myLesson = LessonIndex("", "");

    test('Get book', () {
      myBook = myJournal.availableBooks[0];
      expect(myBook.name, equals("LO4 Matematyka kl3 rozszerzona"));
      expect(myBook.index,
          equals("/p/matematyka-zbior-zadan-do-liceow-i_26.html"));
    });
    test('Get subindex', () async {
      mySubindex = (await myJournal.getSubindex(0))[0];
      expect(
          mySubindex.name,
          equals(
              "1.\u{a0}Ułamki algebraiczne. Równania i nierówności wymierne. Funkcje wymierne."));
      expect(mySubindex.index,
          equals("/2021/08/k3-uamki-algebraiczne-rownania-i.html"));
    });
    test('Get subindex by name', () async {
      mySubindex = (await myJournal
          .getSubindexesbyName("LO4 Matematyka kl3 rozszerzona"))[1];
      expect(mySubindex.name, equals("2. Ciągi."));
      expect(mySubindex.index, equals("/2021/09/2-ciagi.html"));
    });
    test('Get lesson', () async {
      myLesson = (await myJournal.getLessonIndexes(mySubindex))[0];
      expect(myLesson.name,
          equals("1. Określenie ciągu. Sposoby opisywania ciągów."));
      expect(myLesson.link,
          equals("/2021/09/1-okreslenie-ciagu-sposoby-opisywania.html"));
    });
    test('Get task', () async {
      var task = (await myLesson.tasks)[0];
      expect(task.name, equals("Zad. 2.1"));
      expect(task.link, equals("/2021/09/21-klasa-3-4lo.html"));
    });
    test('Get images for task', () async {
      var imgs = await myJournal.getImagesForLessonAndIdx(myLesson, 0);
      expect(
          imgs,
          equals([
            "https://1.bp.blogspot.com/-mwCQB4yLVx0/YUy9yo4vUOI/AAAAAAABKPk/Adl1z6lPlYQW5MMng89aDbXuKB8bYP92ACLcBGAsYHQ/s2048/1.jpg"
          ]));
    });
    test('Get images by task name', () async {
      var imgs = await myJournal.getImageForTaskByName(myLesson, "Zad. 2.2");
      expect(
          imgs,
          equals([
            "https://1.bp.blogspot.com/-McvFB6gw1sw/YUy93yf8SvI/AAAAAAABKPs/LNMTw92MhpgKq_ODqsbQgi9D0J4bkuEqwCLcBGAsYHQ/s2048/2a.jpg",
            "https://1.bp.blogspot.com/-OTCZ1lGwuds/YUy93zv2GdI/AAAAAAABKPo/g6uZxaFFIDAndP6wicTYyPocucQZKyDxACLcBGAsYHQ/s2048/2b.jpg",
            "https://1.bp.blogspot.com/-24A5oy3HIHQ/YUy937PElpI/AAAAAAABKPw/MH6JIQGqoDE3ULJwNZtXdjTwi8qac3ZhQCLcBGAsYHQ/s2048/2c.jpg",
          ]));
    });
    test('Get images from task', () async {
      var task = (await myLesson.tasks)[2];
      var imgs = await myJournal.getImagesForTask(task);
      expect(
          imgs,
          equals([
            "https://1.bp.blogspot.com/-8TD-mp9TOHU/YUy99bI3u2I/AAAAAAABKP0/SiaowmIJhDgHWeRPoZY-h_BHZGeZ-iabgCLcBGAsYHQ/s2048/3.jpg"
          ]));
    });
  });
}
