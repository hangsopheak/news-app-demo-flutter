import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/view_models/article_detail_ui_state.dart';
import 'package:news_app_demo_flutter/providers.dart';


/// ViewModel for Article Detail Screen (MVVM pattern)
class ArticleDetailViewModel extends Notifier<ArticleDetailUiState> {

  int? _articleId;

  @override
  ArticleDetailUiState build() {
    return const ArticleDetailUiState();
  }

  /// Initialize with article ID and load data
  Future<void> initialize(int articleId) async {
    _articleId = articleId;
    await loadArticle(articleId);
  }

  /// Load article by ID
  Future<void> loadArticle(int articleId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(articleRepositoryProvider);
      final article = await repository.getArticleById(articleId);

      state = state.copyWith(
        isLoading: false,
        article: article,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Toggle bookmark for current article
  Future<void> toggleBookmark() async {
    if (state.article == null) return;

    try {
      final repository = ref.read(articleRepositoryProvider);
      final updatedArticle = await repository.toggleBookmark(state.article!);

      state = state.copyWith(article: updatedArticle);
    } catch (e) {
      state = state.copyWith(error: 'Failed to toggle bookmark: $e');
    }
  }


}

/// Provider for ArticleDetailViewModel
final articleDetailViewModelProvider =
NotifierProvider<ArticleDetailViewModel, ArticleDetailUiState>(() {
  return ArticleDetailViewModel();
});