import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';

class CategoriesUiState {
  final bool isLoading;
  final String? error;
  final List<Category> categories;
  final int? selectedCategoryId;

  const CategoriesUiState({
    this.isLoading = false,
    this.error,
    this.categories = const [],
    this.selectedCategoryId,
  });

  CategoriesUiState copyWith({
    bool? isLoading,
    String? error,
    List<Category>? categories,
    int? selectedCategoryId,
  }) {
    return CategoriesUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId,
    );
  }
}

/// UI State for Articles in Explore Screen
class ArticlesUiState {
  final bool isLoading;
  final String? error;
  final List<Article> articles;

  const ArticlesUiState({
    this.isLoading = false,
    this.error,
    this.articles = const [],
  });

  ArticlesUiState copyWith({
    bool? isLoading,
    String? error,
    List<Article>? articles,
  }) {
    return ArticlesUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      articles: articles ?? this.articles,
    );
  }
}

/// UI State for Explore Screen (combines categories and articles)
class ExploreUiState {
  final CategoriesUiState categoriesState;
  final ArticlesUiState articlesState;

  const ExploreUiState({
    this.categoriesState = const CategoriesUiState(),
    this.articlesState = const ArticlesUiState(),
  });

  ExploreUiState copyWith({
    CategoriesUiState? categoriesState,
    ArticlesUiState? articlesState,
  }) {
    return ExploreUiState(
      categoriesState: categoriesState ?? this.categoriesState,
      articlesState: articlesState ?? this.articlesState,
    );
  }
}