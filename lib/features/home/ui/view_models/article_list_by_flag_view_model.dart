import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'article_list_by_flag_ui_state.dart';


class ArticleByFlagViewModel extends Notifier<ArticleByFlagUiState> {

  @override
  ArticleByFlagUiState build() {
    return const ArticleByFlagUiState();
  }

  /// Load articles by flag type
  Future<void> loadArticlesByFlag(int flagId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(articleRepositoryProvider);
      List<Article> articles;

      switch (flagId) {
        case 1:
          articles = await repository.getBreakingNews();
          break;
        case 2:
          articles = await repository.getLatestArticles();
          break;
        case 3:
          articles = await repository.getBreakingNews();
          break;
        case 3:
          articles = await repository.getBookmarkedArticles();
          break;
        default:
          articles = [];
      }
      state = state.copyWith(
        isLoading: false,
        articles: articles
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

}

/// Provider for ArticleByFlagViewModel
final articleByFlagViewModelProvider =
NotifierProvider<ArticleByFlagViewModel, ArticleByFlagUiState>(() {
  return ArticleByFlagViewModel();
});