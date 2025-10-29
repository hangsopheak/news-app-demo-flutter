import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/features/explore/ui/widget/category_filter_chip.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/data/local/category_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';
import 'widget/hero_article_card_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int? _selectedCategoryId; // Track selected category

  List<Article> _getFilteredArticles() {
    if (_selectedCategoryId == null) {
      return ArticleData.allArticles;
    }
    return ArticleData.articlesByCategory[_selectedCategoryId]!.toList();
  }
  @override
  Widget build(BuildContext context) {
    final articles = _getFilteredArticles();

    if (articles.isEmpty) {
      return const Center(
        child: Text('No articles available'),
      );
    }

    final heroArticle = articles.first;
    final remainingArticles = articles.skip(1).toList();

    return Column(

      children:
      [
        const SizedBox(height: 16),

        CategoryFilterChips(
          categories: CategoryData.categories,
          selectedCategoryId: _selectedCategoryId,
          onCategorySelected: (id) {
            setState(() {
              _selectedCategoryId = id;
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: [
              // Hero Article Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: HeroArticleCard(
                  article: heroArticle,
                  onTap: () {
                    debugPrint('Hero article tapped');
                  },
                ),
              ),

              // Remaining Articles List
              ...remainingArticles.map((article) => ArticleCardVerticalWidget(
                article: article,
                onTap: () {
                  debugPrint('Article tapped: ${article.title}');
                },
              )),
            ],
          ),
        )
      ],
    );
  }
}
// Preview
@Preview(name: 'Explore Screen')
Widget ExploreScreenPreview() {
  return MaterialApp(
    theme: NewsAppTheme.lightTheme,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: const ExploreScreen(),
    ),
  );
}