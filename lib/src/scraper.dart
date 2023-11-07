import 'package:web_scraper/web_scraper.dart';

/// Scraper images from website
class Scraper {
  late WebScraper scr;

  Scraper() {
    scr = WebScraper("https://korkimatematyczne.blogspot.com");
  }

  Future<List<String>> getImages(String link) async {
    if (await scr.loadWebPage(_transformToMobile(link))) {
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

  Future<List<String>> getSubindexes(String link) async {
    if (await scr.loadWebPage(_transformToMobile(link))) {
      List<Map<String, dynamic>> elems = scr
          .getElement(".post-body > p:nth-child(6) > a:nth-child(1)", ["href"]);
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

  String _transformToMobile(String link) {
    return link.endsWith("?m=1") ? link : "$link?m=1";
  }
}

class ScraperException implements Exception {
  late String cause;
  ScraperException(String c) {
    cause = "Scraper exceptio: $c";
  }
}
