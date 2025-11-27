import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/home/ui/article_list_by_flag.dart';
import 'package:news_app_demo_flutter/features/home/ui/notifiers/home_notifier.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'widgets/article_items_widget.dart';
import 'widgets/section_title_bar_widget.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        elevation: 0,
      ),
      // 2. Handle States
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorWidget(ref, error),
        data: (state) => _buildHomeContent(context, ref, state),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, WidgetRef ref, dynamic state) {
    // 1. Map data from state
    final List<ArticleSectionData> articleSections = [
      ArticleSectionData(
        title: 'Breaking News',
        articles: state.breakingArticles,
        articleFlagId: 1,
      ),
      ArticleSectionData(
        title: 'Latest News',
        articles: state.latestArticles,
        articleFlagId: 2,
      ),
      ArticleSectionData(
        title: 'Featured News',
        articles: state.featuredArticles,
        articleFlagId: 3,
      ),
    ];

    // 2. Wrap in RefreshIndicator
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(homeProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        // AlwaysScrollableScrollPhysics ensures pull-to-refresh works
        // even if the content is too short to scroll.
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: articleSections.map((sectionData) {
            // Hide sections with no articles
            if (sectionData.articles.isEmpty) return const SizedBox.shrink();

            return ArticleSectionWidget(
              articles: sectionData.articles,
              title: sectionData.title,
              onSeeMoreClicked: () {
                // Navigate to see more
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
      ),
    );
  }

  // Helper 2: Error Widget
  Widget _buildErrorWidget(WidgetRef ref, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something went wrong:\n$error', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.read(homeProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// --- Helper Components ---

class ArticleSectionWidget extends StatelessWidget {
  final List<Article> articles;
  final String title;
  final VoidCallback? onSeeMoreClicked;

  const ArticleSectionWidget({
    super.key,
    required this.articles,
    required this.title,
    this.onSeeMoreClicked,
  });

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

// Simple Helper Data Class
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