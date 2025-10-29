import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/data/local/home_data.dart';
import 'package:news_app_demo_flutter/features/home/domain/model/article_section_data.dart';
import 'package:news_app_demo_flutter/features/home/ui/article_list_by_flag.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'widgets/article_items_widget.dart';
import 'widgets/section_title_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ArticleSectionData> articleSections = [
      ArticleSectionData(
        title: 'Breaking News',
        articles: HomeData.breakingArticles,
        articleFlagId: 1,
      ),
      ArticleSectionData(
        title: 'Latest News',
        articles: HomeData.latestArticles,
        articleFlagId: 2,
      ),
      ArticleSectionData(
        title: 'Featured News',
        articles: HomeData.featuredArticles,
        articleFlagId: 3,
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: articleSections.map((sectionData) {
          return ArticleSectionWidget(
            articles: sectionData.articles,
            title: sectionData.title,
            onSeeMoreClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleListByFlagScreen(
                    articleFlagId: sectionData.articleFlagId,
                    flagDescription: sectionData.title,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class ArticleSectionWidget extends StatelessWidget {

  final List<Article> articles;
  final String title;
  final VoidCallback? onSeeMoreClicked;
  const ArticleSectionWidget({super.key, required this.articles, required this.title, this.onSeeMoreClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitleBarWidget(title: title, onSeeMoreClicked: onSeeMoreClicked),
        ArticleItemsWidget(articles: articles),
      ],
    );
  }
}

