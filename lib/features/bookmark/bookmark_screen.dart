import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  List<Article> _getBookmarkedArticles() {
    return ArticleData.allArticles
        .where((article) => article.isBookMarked)
        .toList();
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
    final bookmarkedArticles = _getBookmarkedArticles();

    return bookmarkedArticles.isEmpty
        ? const Center(
      child: Text('No bookmarked articles'),
    )
        : ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      itemCount: bookmarkedArticles.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return ArticleCardVerticalWidget(
          article: bookmarkedArticles[index],
          onTap: () => _onArticleTap(context, bookmarkedArticles[index]),
        );
      },
    );
  }
}