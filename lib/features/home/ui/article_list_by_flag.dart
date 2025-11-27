import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/ui/notifiers/article_list_by_flag_notifier.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class ArticleListByFlagScreen extends ConsumerWidget {
  final int articleFlagId;
  final String flagDescription;

  const ArticleListByFlagScreen({
    super.key,
    required this.articleFlagId,
    required this.flagDescription,
  });

  void _onArticleTap(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the Family Provider
    // Pass the 'articleFlagId' to get the specific list for this screen
    final asyncArticles = ref.watch(articleListByFlagProvider(articleFlagId));

    return Scaffold(
      appBar: AppBar(
        title: Text(flagDescription),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // 2. Handle the 3 Async States
      body: asyncArticles.when(
        // Loading State
        loading: () => const Center(child: CircularProgressIndicator()),

        // Error State
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading articles:\n$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Retry logic for family provider
                  ref.read(articleListByFlagProvider(articleFlagId).notifier).refresh();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),

        // Data State
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No articles found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Call refresh on the specific family member
              await ref.read(articleListByFlagProvider(articleFlagId).notifier).refresh();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even if list is short
              padding: const EdgeInsets.all(16),
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
        },
      ),
    );
  }
}