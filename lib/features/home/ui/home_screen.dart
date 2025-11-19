import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/data/local/home_data.dart';
import 'package:news_app_demo_flutter/features/home/domain/model/article_section_data.dart';
import 'package:news_app_demo_flutter/features/home/ui/article_list_by_flag.dart';
import 'package:news_app_demo_flutter/l10n/app_localizations.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'view_models/home_view_model.dart';
import 'widgets/article_items_widget.dart';
import 'widgets/section_title_bar_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final homeState = ref.watch(homeViewModelProvider);
    if (homeState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Handle error state
    if (homeState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${homeState.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(homeViewModelProvider.notifier).loadHomeData(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }


    final List<ArticleSectionData> articleSections = [
      ArticleSectionData(
        title: AppLocalizations.of(context)!.breaking_news,
        articles: homeState.breakingArticles,
        articleFlagId: 1,
      ),
      ArticleSectionData(
        title: AppLocalizations.of(context)!.latest_news,
        articles: homeState.latestArticles,
        articleFlagId: 2,
      ),
      ArticleSectionData(
        title: AppLocalizations.of(context)!.feature_news,
        articles: homeState.featuredArticles,
        articleFlagId: 3,
      ),
    ];
    // Pull-to-refresh support
    return RefreshIndicator(
      onRefresh: () => ref.read(homeViewModelProvider.notifier).loadHomeData(),
      child: SingleChildScrollView(
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

