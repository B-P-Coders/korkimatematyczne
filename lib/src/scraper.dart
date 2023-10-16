import 'package:web_scraper/web_scraper.dart';

/// Scraper images from website
class Scraper {
  late WebScraper scr;

  Scraper() {
    scr = WebScraper("https://korkimatematyczne.blogspot.com");
  }

  Future<List<String>> getImages(String link) async {
    if (await scr.loadWebPage(link)) {
      List<Map<String, dynamic>> elems =
          scr.getElement(".separator > a", ["href"]);
      final res = elems.map((e) => e['attributes']['href'] as String).toList();

      if (res.isEmpty) {
        throw ScraperException(
            "No images on specified endpoint ${scr.baseUrl}$link");
      }
      return res;
    } else {
      throw ScraperException(
          "Could not load images from specified url ${scr.baseUrl}$link");
    }
  }
}

class ScraperException implements Exception {
  late String cause;
  ScraperException(String c) {
    cause = "Scraper exceptio: $c";
  }
}
