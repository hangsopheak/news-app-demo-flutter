import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class BookmarkUiState {
  final bool isLoading;
  final String? error;
  final List<Article> articles;

  const BookmarkUiState({
    this.isLoading = false,
    this.error,
    this.articles = const [],
  });

  BookmarkUiState copyWith({
    bool? isLoading,
    String? error,
    List<Article>? articles,
  }) {
    return BookmarkUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      articles: articles ?? this.articles,
    );
  }
}
