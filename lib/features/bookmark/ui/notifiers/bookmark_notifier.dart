import 'package:news_app_demo_flutter/features/bookmark/data/repository/bookmark_repository.dart';
import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_notifier.g.dart';

@riverpod
class BookmarkNotifier extends _$BookmarkNotifier {

  @override
  Future<List<Article>> build() async {
    // We listen to the repo so if the repo instance ever changes, we reload.
    final repository = ref.watch(bookmarkRepositoryProvider);
    return repository.getBookmarkedArticles();
  }

  /// Manually refresh the list (e.g. Pull-to-Refresh)
  Future<void> refresh() async {
    // This sets state to AsyncLoading, runs build(), and then updates state
    ref.invalidateSelf();
    await future;
  }
}