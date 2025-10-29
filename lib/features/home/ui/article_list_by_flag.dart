import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class ArticleListByFlagScreen extends StatelessWidget {
  final int articleFlagId;
  final String flagDescription;

  const ArticleListByFlagScreen({
    super.key,
    required this.articleFlagId,
    required this.flagDescription,
  });

  List<Article> _getArticlesByFlag() {
    switch (articleFlagId) {
      case 1:
        return ArticleData.breakingArticles;
      case 2:
        return ArticleData.latestArticles;
      case 3:
        return ArticleData.featuredArticles;
      default:
        return [];
    }
  }

  void _onArticleTap(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = _getArticlesByFlag();

    return Scaffold(
      appBar: AppBar(
        title: Text(flagDescription),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: articles.isEmpty
          ? const Center(
        child: Text('No articles found'),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ArticleCardVerticalWidget(
            article: articles[index],
            onTap: () => _onArticleTap(context, articles[index]),
          );
        },
      ),
    );
  }
}