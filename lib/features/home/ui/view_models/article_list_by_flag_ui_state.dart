import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class ArticleByFlagUiState {
  final bool isLoading;
  final String? error;
  final List<Article> articles;

  const ArticleByFlagUiState({
    this.isLoading = false,
    this.error,
    this.articles = const [],
  });

  ArticleByFlagUiState copyWith({
    bool? isLoading,
    String? error,
    List<Article>? articles,
  }) {
    return ArticleByFlagUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      articles: articles ?? this.articles,
    );
  }
}
