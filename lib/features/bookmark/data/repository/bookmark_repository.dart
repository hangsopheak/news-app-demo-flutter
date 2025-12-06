import 'package:news_app_demo_flutter/features/bookmark/data/local/bookmark_provider.dart';
import 'package:news_app_demo_flutter/features/bookmark/data/local/bookmark_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_repository.g.dart';

@Riverpod(keepAlive: true)
BookmarkRepository bookmarkRepository(Ref ref) {
  // Inject the Service we created in main.dart
  final service = ref.watch(bookmarkServiceProvider);
  return BookmarkRepository(service);
}

class BookmarkRepository {
  final BookmarkService _service;

  BookmarkRepository(this._service);

  Future<void> toggleBookmark(Article article) =>
      _service.toggleBookmark(article);

  Future<List<Article>> getBookmarkedArticles() async =>
      _service.getAllBookmarks();

  Stream<bool> watchArticleBookmarkStatus(int articleId) =>
      _service.watchArticleBookmarkStatus(articleId);

  bool isBookmarked(int id) => _service.isBookmarked(id);
}