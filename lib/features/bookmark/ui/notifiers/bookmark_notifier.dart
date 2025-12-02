import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_notifier.g.dart';

@riverpod
class BookmarkNotifier extends _$BookmarkNotifier {

  @override
  Future<List<Article>> build() async {
    return _fetchBookmarks();
  }

  Future<List<Article>> _fetchBookmarks() async {
    final repository = ref.watch(articleRepositoryProvider);
    return repository.getBookmarkedArticles();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}