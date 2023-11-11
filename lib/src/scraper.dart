import 'package:web_scraper/web_scraper.dart';

import 'models.dart';

/// Scraper images from website
class Scraper {
  late WebScraper _scr;

  Scraper() {
    _scr = WebScraper("https://korkimatematyczne.blogspot.com");
  }

  Future<List<String>> getImages(String link) async {
    if (await _scr.loadWebPage(_transformToMobile(link))) {
      List<Map<String, dynamic>> elems =
          _scr.getElement(".separator > a", ["href"]);
      final res = elems
          .map((e) => _stripFull(e['attributes']['href']) as String)
          .toList();

      if (res.isEmpty) {
        throw ScraperException(
            "No images on specified endpoint ${_scr.baseUrl}$link");
      }
      return res;
    } else {
      throw ScraperException(
          "Could not load images from specified url ${_scr.baseUrl}$link");
    }
  }

  Future<List<Subindex>> getSubindexeses(String link) async {
    if (await _scr.loadWebPage(_transformToMobile(link))) {
      final subindexes = _scr
          .getElement(".post-body > p > a", ['href'])
          .map((e) => Subindex(e['title'], _stripFull(e['attributes']['href'])))
          .toList();
      if (link.isEmpty) {
        throw ScraperException(
            "Could not read subindex on ${_scr.baseUrl}$link");
      }
      return subindexes;
    } else {
      throw ScraperException(
          "Could not load subindex page ${_scr.baseUrl}$link");
    }
  }

  Future<List<LessonIndex>> getLessonIndexes(String link) async {
    if (await _scr.loadWebPage(_transformToMobile(link))) {
      List<LessonIndex> lessonindexes = _scr
          .getElement(".post-body > p > a", ['href'])
          .map((e) =>
              LessonIndex(e['title'], _stripFull(e['attributes']['href'])))
          .map((e) {
            e.tasks = _getTasks(e.link);
            return e;
          })
          .toList();
      return lessonindexes;
    } else {
      throw ScraperException(
          "Could not load lesson index page ${_scr.baseUrl}$link");
    }
  }

  Future<List<Task>> _getTasks(String link) async {
    if (await _scr.loadWebPage(_transformToMobile(link))) {
      List<Task> tasks = _scr
          .getElement(".post-body > p > a", ['href'])
          .map((e) => Task(e['title'], _stripFull(e['attributes']['href'])))
          .toList();
      return tasks;
    } else {
      throw ScraperException(
          "Could not load lesson index page ${_scr.baseUrl}$link");
    }
  }

  String _transformToMobile(String link) {
    return link.endsWith("?m=1") ? link : "$link?m=1";
  }

  String _stripFull(String link) {
    return link.startsWith(_scr.baseUrl!)
        ? link.replaceFirst(_scr.baseUrl!, "")
        : link;
  }
}

class ScraperException implements Exception {
  late String cause;
  ScraperException(String c) {
    cause = "Scraper exceptio: $c";
  }
}
