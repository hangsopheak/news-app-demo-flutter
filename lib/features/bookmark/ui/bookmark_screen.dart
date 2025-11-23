import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/bookmark/ui/view_models/bookmark_view_model.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookmarkViewModelProvider.notifier).loadBookmarkArticles();
    });
  }

  void _onArticleTap(BuildContext context, Article article) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
    // Reload after returning from detail screen
    ref.read(bookmarkViewModelProvider.notifier).loadBookmarkArticles();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkState = ref.watch(bookmarkViewModelProvider);
    if (bookmarkState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookmarkState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${bookmarkState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(bookmarkViewModelProvider.notifier).loadBookmarkArticles();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final bookmarkedArticles = bookmarkState.articles;

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