import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'explore_ui_state.dart';

/// ViewModel for Explore Screen (MVVM pattern)
class ExploreViewModel extends Notifier<ExploreUiState> {
  @override
  ExploreUiState build() {
    return const ExploreUiState();
  }

  /// Load categories
  Future<void> loadCategories() async {
    state = state.copyWith(
      categoriesState: state.categoriesState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final repository = ref.read(categoryRepositoryProvider);
      final categories = await repository.getCategories();

      state = state.copyWith(
        categoriesState: state.categoriesState.copyWith(
          isLoading: false,
          categories: categories,
        ),
      );

      // Auto-load articles for first category if available
      if (categories.isNotEmpty && state.categoriesState.selectedCategoryId == null) {
        await selectCategory(categories.first.id);
      }
    } catch (e) {
      state = state.copyWith(
        categoriesState: state.categoriesState.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  /// Select a category and load its articles
  Future<void> selectCategory(int categoryId) async {
    // Update selected category
    state = state.copyWith(
      categoriesState: state.categoriesState.copyWith(
        selectedCategoryId: categoryId,
      ),
      articlesState: state.articlesState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final repository = ref.read(articleRepositoryProvider);
      final articles = await repository.getArticlesByCategory(categoryId);

      state = state.copyWith(
        articlesState: state.articlesState.copyWith(
          isLoading: false,
          articles: articles,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        articlesState: state.articlesState.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  /// Load all articles (no category filter)
  Future<void> loadAllArticles() async {
    state = state.copyWith(
      categoriesState: state.categoriesState.copyWith(
        selectedCategoryId: null,
      ),
      articlesState: state.articlesState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final repository = ref.read(articleRepositoryProvider);
      final articles = await repository.getArticles();

      state = state.copyWith(
        articlesState: state.articlesState.copyWith(
          isLoading: false,
          articles: articles,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        articlesState: state.articlesState.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

}

/// Provider for ExploreViewModel
final exploreViewModelProvider = NotifierProvider<ExploreViewModel, ExploreUiState>(() {
  return ExploreViewModel();
});