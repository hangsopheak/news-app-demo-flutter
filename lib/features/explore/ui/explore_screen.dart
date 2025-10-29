import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/core/utils/device/device_utility.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
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
  int? _selectedCategoryId;

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

    final isDesktop = DeviceUtils.getScreenWidth(context) > 800;

    return Column(
      children: [
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
          // NEW: Split into separate widget for clarity
          child: _ArticleListContent(
            articles: articles,
            isDesktop: isDesktop,
          ),
        ),
      ],
    );
  }
}

// NEW: Separate widget for article list content
class _ArticleListContent extends StatelessWidget {
  final List<Article> articles;
  final bool isDesktop;

  const _ArticleListContent({
    required this.articles,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final heroArticle = articles.first;
    final remainingArticles = articles.skip(1).toList();

    return CustomScrollView(
      slivers: [
        // Hero Article
        _buildHeroArticle(context, heroArticle),

        // Remaining Articles (Grid or List)
        if (isDesktop)
          _buildArticleGrid(context, remainingArticles)
        else
          _buildArticleList(context, remainingArticles),
      ],
    );
  }

  // NEW: Extract hero article builder
  Widget _buildHeroArticle(BuildContext context, Article heroArticle) {
    return SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 1200 : double.infinity,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: HeroArticleCard(
              article: heroArticle,
              onTap: () => _navigateToDetail(context, heroArticle),
            ),
          ),
        ),
      ),
    );
  }

  // NEW: Extract grid builder for desktop
  Widget _buildArticleGrid(BuildContext context, List<Article> articles) {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return ArticleCardVerticalWidget(
              article: articles[index],
              onTap: () => _navigateToDetail(context, articles[index]),
            );
          },
          childCount: articles.length,
        ),
      ),
    );
  }

  // NEW: Extract list builder for mobile
  Widget _buildArticleList(BuildContext context, List<Article> articles) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return ArticleCardVerticalWidget(
            article: articles[index],
            onTap: () => _navigateToDetail(context, articles[index]),
          );
        },
        childCount: articles.length,
      ),
    );
  }

  // NEW: Extract navigation method to avoid repetition
  void _navigateToDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
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