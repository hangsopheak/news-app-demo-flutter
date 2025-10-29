import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/home/data/local/home_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'widgets/article_items_widget.dart';
import 'widgets/section_title_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArticleSectionWidget(articles: HomeData.breakingArticles, title: 'Breaking News'),
        ArticleSectionWidget(articles: HomeData.latestArticles, title: 'Latest News'),
        ArticleSectionWidget(articles: HomeData.featuredArticles, title: 'Featured News'),
      ],
    );
  }
}

class ArticleSectionWidget extends StatelessWidget {

  final List<Article> articles;
  final String title;
  const ArticleSectionWidget({super.key, required this.articles, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitleBarWidget(title: title),
        ArticleItemsWidget(articles: articles),
      ],
    );
  }
}

