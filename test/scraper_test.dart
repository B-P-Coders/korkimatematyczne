import 'package:korkimatematyczne/src/scraper.dart';
import 'package:test/test.dart';

// Tests of scraper submodule
void main() {
  group('Scraper tests', () {
    late Scraper myScraper;

    setUp(() {
      myScraper = Scraper();
    });

    test('Single image', () async {
      expect(
          await myScraper.getImages("/2021/10/2190-klasa-3-4lo.html?m=1"),
          equals([
            "https://blogger.googleusercontent.com/img/a/AVvXsEgVhMwgtJNUlmoc0ydgDWhUUB5pS4WUHfbe6awCwig6Xdmr8-4M8YPCHklXXQGggHD-us2eBHOHCmhr3dl6zObSrc7dQua0UdRsc4jh5J-HCEu-9oi_EQAZ0L_e3eRzRT9MB0O9ysu-0zccybQMksk-gyWULQQXDcH8Bz43edymUnu3WPfgRtdsLNp4=s2048"
          ]));
    });

    test('Single image with mobile transformer reuired', () async {
      expect(
          await myScraper.getImages("/2021/10/2190-klasa-3-4lo.html"),
          equals([
            "https://blogger.googleusercontent.com/img/a/AVvXsEgVhMwgtJNUlmoc0ydgDWhUUB5pS4WUHfbe6awCwig6Xdmr8-4M8YPCHklXXQGggHD-us2eBHOHCmhr3dl6zObSrc7dQua0UdRsc4jh5J-HCEu-9oi_EQAZ0L_e3eRzRT9MB0O9ysu-0zccybQMksk-gyWULQQXDcH8Bz43edymUnu3WPfgRtdsLNp4=s2048"
          ]));
    });

    test('Multiple images', () async {
      expect(
          await myScraper.getImages("/2021/10/2191-klasa-3-4lo.html"),
          equals([
            "https://blogger.googleusercontent.com/img/a/AVvXsEhuMFHFaMwdEVYLWMuNsHhYx21VbnCIyumfZM6DRw4BJC8fCGBS30L1QMQmQSjfD8RtuG_KdFTjt5X6XysY4amDOMedqDANzqOBQSdg72JBnlxwDPrlT6tiFXHXKth6ohzueneIJnaWtiVnnlY-xKkmUEGAEhoAvAJU1A61HNmuM9tlCtQcN7ZU2J6r=s2048",
            "https://blogger.googleusercontent.com/img/a/AVvXsEj132FKkgT8rv5J2jIHw5-K1jMvUYWRLeYj-3JGo_SojUcvZ-qjosMTxt8JIx4MV65frzPoKCU5BebNhqp5e-nCuXDHi5N_kr5yR3g_2rKu5h9-iMY0_DTKbPr-g00TcXziHegSfQR5uOHyyMk5FrWL_HblLMp3cdJdiV3PF--QJsG-GR9CAyaPk53s=s2048",
          ]));
    });

    test('Invalid link', () async {
      expect(
          myScraper.getImages("/asdflasdlkfjlas").catchError((e) => throw e),
          throwsA(
            isA<ScraperException>(),
          ));
    });

    test('Subindex', () async {
      final subindexes = await myScraper
          .getSubindexeses("/p/matematyka-zbior-zadan-do-liceow-i_26.html");
      expect(
          subindexes[0].name,
          equals(
              "1.\u{a0}Ułamki algebraiczne. Równania i nierówności wymierne. Funkcje wymierne."));
      expect(
          subindexes[7].index,
          equals(
            "/2022/02/8-geometria-analityczna-pr.html",
          ));
    });

    test('Lesson index', () async {
      final lessonindexes = await myScraper
          .getLessonIndexes("/2022/02/8-geometria-analityczna-pr.html");
      expect(lessonindexes[0].name,
          equals("1. Wektor w układzie współrzędnych. Podział odcinka."));
      expect(
          lessonindexes[0].link,
          equals(
            "/2022/02/1-wektor-w-ukadzie-wsporzednych-podzia.html",
          ));
      final tasks0 = await lessonindexes[0].tasks;
      expect(tasks0[0].name, equals("\u{a0}Zad. 8.1"));
      expect(tasks0[0].link, equals("/2022/02/801-klasa-3-4lo-pr.html"));
    });
  });
}
