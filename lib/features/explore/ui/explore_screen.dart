import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/core/utils/device/device_utility.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/explore/ui/widget/category_filter_chip.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/data/local/category_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';
import 'notifiers/explore_notifiers.dart';
import 'widget/hero_article_card_widget.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the articles provider (Logic is handled in the provider)
    final asyncArticles = ref.watch(exploreArticlesProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // 2. The Filter Bar is its own consumer to load independently
            const _CategoryFilterBar(),
            const SizedBox(height: 16),

            // 3. The Article List Area
            Expanded(
              child: asyncArticles.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (articles) {
                  if (articles.isEmpty) {
                    return const Center(child: Text('No articles available'));
                  }

                  // Use RefreshIndicator to reload articles
                  return RefreshIndicator(
                    onRefresh: () => ref.refresh(exploreArticlesProvider.future),
                    child: _ArticleListContent(articles: articles),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Component: Category Filter Bar
// -----------------------------------------------------------------------------
class _CategoryFilterBar extends ConsumerWidget {
  const _CategoryFilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(exploreCategoriesProvider);
    final selectedId = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 55,
      child: asyncCategories.when(
        loading: () => const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
        error: (_, __) => const SizedBox(), // Hide bar on error
        data: (categories) {
          return CategoryFilterChips(
            categories: categories,
            selectedCategoryId: selectedId,
            onCategorySelected: (id) {
              ref.read(selectedCategoryProvider.notifier).select(id);
            },
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Component: Article List Content
// -----------------------------------------------------------------------------
class _ArticleListContent extends StatelessWidget {
  final List<Article> articles;

  const _ArticleListContent({required this.articles});

  @override
  Widget build(BuildContext context) {
    // Separate the first article as the "Hero"
    final heroArticle = articles.first;
    final remainingArticles = articles.skip(1).toList();

    return CustomScrollView(
      // Ensure physics allows pull-to-refresh even if list is short
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // 1. Hero Article (Full width)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: HeroArticleCard(
              article: heroArticle,
              onTap: () => _navigateToDetail(context, heroArticle),
            ),
          ),
        ),

        // 2. Remaining Articles (Standard Vertical List)
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final article = remainingArticles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ArticleCardVerticalWidget(
                    article: article,
                    onTap: () => _navigateToDetail(context, article),
                  ),
                );
              },
              childCount: remainingArticles.length,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }
}