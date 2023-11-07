import 'package:web_scraper/web_scraper.dart';

import 'book_index.dart';

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

  Future<List<Subindex>> getSubindexes(String link) async {
    if (await scr.loadWebPage(_transformToMobile(link))) {
      List<Map<String, dynamic>> elems =
          scr.getElement(".post-body > p > a", ['href']);
      final subindexes = elems
          .map((e) => Subindex(e['title'], e['attributes']['href']))
          .toList();
      if (link.isEmpty) {
        throw ScraperException(
            "Could not read subindex on ${scr.baseUrl}$link");
      }
      return subindexes;
    } else {
      throw ScraperException(
          "Could not load subindex page ${scr.baseUrl}$link");
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
