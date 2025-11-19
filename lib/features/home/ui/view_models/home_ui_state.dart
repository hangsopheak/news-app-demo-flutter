import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class HomeUiState {
  final bool isLoading;
  final String? error;
  final List<Article> breakingArticles;
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  const HomeUiState({
    this.isLoading = false,
    this.error,
    this.breakingArticles = const [],
    this.featuredArticles = const [],
    this.latestArticles = const [],
  });

  HomeUiState copyWith({
    bool? isLoading,
    String? error,
    List<Article>? breakingArticles,
    List<Article>? featuredArticles,
    List<Article>? latestArticles,
  }) {
    return HomeUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      breakingArticles: breakingArticles ?? this.breakingArticles,
      featuredArticles: featuredArticles ?? this.featuredArticles,
      latestArticles: latestArticles ?? this.latestArticles,
    );
  }
}