import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/features/explore/ui/widget/category_filter_chip.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/data/local/category_data.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';
import 'widget/hero_article_card_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = ArticleData.allArticles;

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
            onCategorySelected: (id) {
              debugPrint('Category selected: $id');
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