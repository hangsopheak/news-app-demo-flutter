import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class BookmarkService {
  static const String _boxName = 'bookmarks';
  Box<Map<dynamic, dynamic>>? _bookmarkBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _bookmarkBox = await Hive.openBox<Map>(_boxName);
  }

  bool get isInitialized => _bookmarkBox != null && _bookmarkBox!.isOpen;

  Future<void> addBookmark(Article article) async {
    final json = article.copyWith(isBookMarked: true).toJson();
    await _bookmarkBox!.put(article.id, json);
  }

  Future<void> removeBookmark(int articleId) async {
    await _bookmarkBox!.delete(articleId);
  }

  Future<void> toggleBookmark(Article article) async {
    final exists = _bookmarkBox!.containsKey(article.id);

    if (exists) {
      await _bookmarkBox!.delete(article.id);
    } else {
      final json = article.copyWith(isBookMarked: true).toJson();
      await _bookmarkBox!.put(article.id, json);
    }
  }


  List<Article> getAllBookmarks() {
    return _bookmarkBox!.values.map((json) {
      // Hive returns raw Map<Object?, Object?> — convert to Map<String, dynamic>
      // so Article.fromJson() can parse it safely.
      final jsonMap = Map<String, dynamic>.from(json as Map);

      // Convert nested map (category) for the same reason.
      if (jsonMap['category'] is Map) {
        jsonMap['category'] = Map<String, dynamic>.from(jsonMap['category']);
      }

      return Article.fromJson(jsonMap);
    }).toList();
  }

  bool isBookmarked(int articleId) {
    return _bookmarkBox!.containsKey(articleId);
  }

  /// Watches the bookmark status of a specific article.
  ///
  /// Why a Stream?
  /// - Because bookmark status can change over time (user toggles bookmark).
  /// - The UI needs to update automatically whenever that happens.
  ///
  /// How it works:
  /// 1. If the bookmark storage is not ready yet, emit `false` and stop.
  /// 2. Emit the **current** bookmark status immediately so the UI shows the
  ///    correct state on page load.
  /// 3. Then listen to any changes in the bookmark box (`watch()`).
  ///    Every time the local DB updates, re-check whether this article is
  ///    bookmarked and emit the updated value.
  Stream<bool> watchArticleBookmarkStatus(int articleId) async* {
    // Storage is not initialized yet → cannot check bookmark status
    if (!isInitialized) {
      yield false;
      return;
    }

    // Emit initial value so UI shows current bookmark state immediately
    yield isBookmarked(articleId);

    // Listen for any bookmark changes in local storage (Hive)
    // Every change triggers a new event, so we map it to the updated status
    yield* _bookmarkBox!.watch().map((_) => isBookmarked(articleId));
  }

}
