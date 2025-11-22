import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/core/utils/device/device_utility.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/explore/ui/view_models/explore_ui_state.dart';
import 'package:news_app_demo_flutter/features/explore/ui/view_models/explore_view_model.dart';
import 'package:news_app_demo_flutter/features/explore/ui/widget/category_filter_chip.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';
import 'widget/hero_article_card_widget.dart';


class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    // MODIFIED: Load categories only ONCE when screen opens
    Future.microtask(() {
      ref.read(exploreViewModelProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    // MODIFIED: Watch the explore state from ViewModel
    final exploreState = ref.watch(exploreViewModelProvider);
    final viewModel = ref.read(exploreViewModelProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 16),

        // MODIFIED: Added loading and error states for categories
        if (exploreState.categoriesState.isLoading)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          )
        else if (exploreState.categoriesState.error != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: ${exploreState.categoriesState.error}'),
          )
        else
        // MODIFIED: Categories now come from ViewModel state instead of local data
          CategoryFilterChips(
            categories: exploreState.categoriesState.categories,
            selectedCategoryId: exploreState.categoriesState.selectedCategoryId,
            // MODIFIED: Use ViewModel method instead of setState
            onCategorySelected: (categoryId) => viewModel.loadArticles(categoryId),
          ),

        const SizedBox(height: 16),

        Expanded(
          child: _buildArticlesContent(context, exploreState, viewModel),
        ),
      ],
    );
  }

  // MODIFIED: New method to handle articles loading, error, and empty states
  Widget _buildArticlesContent(
      BuildContext context,
      ExploreUiState exploreState,
      ExploreViewModel viewModel,
      ) {
    final articlesState = exploreState.articlesState;

    // MODIFIED: Show loading indicator while fetching articles
    if (articlesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // MODIFIED: Show error message with retry button
    if (articlesState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${articlesState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadCategories(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // MODIFIED: Articles now come from ViewModel state
    if (articlesState.articles.isEmpty) {
      return const Center(child: Text('No articles available'));
    }

    final isDesktop = DeviceUtils.getScreenWidth(context) > 800;

    return _ArticleListContent(
      articles: articlesState.articles,
      isDesktop: isDesktop,
    );
  }
}

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
        _buildHeroArticle(context, heroArticle),
        if (isDesktop)
          _buildArticleGrid(context, remainingArticles)
        else
          _buildArticleList(context, remainingArticles),
      ],
    );
  }

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

  Widget _buildArticleList(BuildContext context, List<Article> articles) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ArticleCardVerticalWidget(
                article: articles[index],
                onTap: () => _navigateToDetail(context, articles[index]),
              ),
            );
          },
          childCount: articles.length,
        ),
      ),
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