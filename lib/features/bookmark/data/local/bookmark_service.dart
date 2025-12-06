import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class BookmarkService {
  final Box<Map> _bookmarkBox;

  // Dependency Injection: Pass the already opened box
  BookmarkService(this._bookmarkBox);

  // -------------------------------------------------------
  // 1. SAFE CASTING HELPER
  // -------------------------------------------------------
  /// Hive returns Map<dynamic, dynamic>. This helper safely converts it
  /// to Map<String, dynamic> so .fromJson() works nicely.
  Map<String, dynamic> _safeCast(Map<dynamic, dynamic> data) {
    return data.cast<String, dynamic>().map((key, value) {
      if (value is Map) {
        // Recursively cast nested maps (like 'category' )
        return MapEntry(key, _safeCast(value));
      }
      return MapEntry(key, value);
    });
  }

  // -------------------------------------------------------
  // 2. CRUD OPERATIONS
  // -------------------------------------------------------
  Future<void> addBookmark(Article article) async {
    // We explicitly set isBookMarked to true before saving
    final json = article.copyWith(isBookMarked: true).toJson();
    await _bookmarkBox.put(article.id, json);
  }

  Future<void> removeBookmark(int articleId) async {
    await _bookmarkBox.delete(articleId);
  }

  Future<void> toggleBookmark(Article article) async {
    if (isBookmarked(article.id)) {
      await removeBookmark(article.id);
    } else {
      await addBookmark(article);
    }
  }

  bool isBookmarked(int articleId) {
    return _bookmarkBox.containsKey(articleId);
  }

  List<Article> getAllBookmarks() {
    return _bookmarkBox.values.map((rawMap) {
      // Use the helper! Much cleaner.
      final jsonMap = _safeCast(rawMap);
      return Article.fromJson(jsonMap);
    }).toList();
  }

  Stream<bool> watchArticleBookmarkStatus(int articleId) async* {
    // 1. Emit current status immediately
    yield isBookmarked(articleId);

    // 2. Watch ONLY this specific key
    // This is much more efficient than watching the whole box.
    yield* _bookmarkBox
        .watch(key: articleId)
        .map((event) => !event.deleted && event.value != null);
  }
}