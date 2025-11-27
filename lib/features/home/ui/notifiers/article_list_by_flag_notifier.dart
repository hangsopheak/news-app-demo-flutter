import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

part 'article_list_by_flag_notifier.g.dart';

// We use a "Family" notifier because we need the flagId to build the state.
@riverpod
class ArticleListByFlagNotifier extends _$ArticleListByFlagNotifier {

  // The 'flagId' argument here automatically makes this a family provider.
  @override
  Future<List<Article>> build(int flagId) async {
    return _fetchArticles(flagId);
  }

  Future<List<Article>> _fetchArticles(int flagId) async {
    final repository = ref.watch(articleRepositoryProvider);

    // Switch logic to pick the right repository method
    switch (flagId) {
      case 1:
        return repository.getBreakingNews();
      case 2:
        return repository.getLatestArticles();
      case 3:
        return repository.getFeaturedArticles();
      case 4:
        return repository.getBookmarkedArticles();
      default:
        return [];
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

