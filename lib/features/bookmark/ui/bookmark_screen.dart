import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/bookmark/ui/notifiers/bookmark_notifier.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the Notifier
    final asyncBookmarks = ref.watch(bookmarkProvider);

    return asyncBookmarks.when(
      // Loading State
      loading: () => const Center(child: CircularProgressIndicator()),

      // Error State
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(bookmarkProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),

      // Success State
      data: (bookmarkedArticles) {
        if (bookmarkedArticles.isEmpty) {
          return const Center(child: Text('No bookmarked articles'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(bookmarkProvider.notifier).refresh();
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            itemCount: bookmarkedArticles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return ArticleCardVerticalWidget(
                article: bookmarkedArticles[index],
                onTap: () => _onArticleTap(context, ref, bookmarkedArticles[index]),
              );
            },
          ),
        );
      },
    );
  }

  void _onArticleTap(BuildContext context, WidgetRef ref, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }
}