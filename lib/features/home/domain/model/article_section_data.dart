import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class ArticleSectionData {
  final String title;
  final List<Article> articles;
  final int articleFlagId;

  ArticleSectionData({
    required this.title,
    required this.articles,
    required this.articleFlagId,
  });
}