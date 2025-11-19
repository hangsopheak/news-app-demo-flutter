import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class ArticleDetailUiState {
  final bool isLoading;
  final String? error;
  final Article? article;

  const ArticleDetailUiState({
    this.isLoading = false,
    this.error,
    this.article,
  });

  ArticleDetailUiState copyWith({
    bool? isLoading,
    String? error,
    Article? article,
  }) {
    return ArticleDetailUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      article: article ?? this.article,
    );
  }
}