import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class HomeUiState {
  final List<Article> breakingArticles;
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  const HomeUiState({
    this.breakingArticles = const [],
    this.featuredArticles = const [],
    this.latestArticles = const [],
  });

  HomeUiState copyWith({
    List<Article>? breakingArticles,
    List<Article>? featuredArticles,
    List<Article>? latestArticles,
  }) {
    return HomeUiState(
      breakingArticles: breakingArticles ?? this.breakingArticles,
      featuredArticles: featuredArticles ?? this.featuredArticles,
      latestArticles: latestArticles ?? this.latestArticles,
    );
  }
}