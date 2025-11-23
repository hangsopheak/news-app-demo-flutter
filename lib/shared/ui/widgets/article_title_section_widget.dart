import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/core/utils/date_format_util.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

/// Watch real-time bookmark status for an article
final isArticleBookmarkedProvider =
StreamProvider.family<bool, int>((ref, articleId) {
  final repo = ref.watch(articleRepositoryProvider);
  return repo.watchArticleBookmarkStatus(articleId);
});

/// Simple provider that exposes the toggle function
final toggleBookmarkProvider = Provider((ref) {
  final repo = ref.read(articleRepositoryProvider);
  return repo.toggleBookmark;
});


class ArticleTitleSectionWidget extends ConsumerWidget {
  final Article article;
  final double titleFontSize;
  final bool showBookMark;
  final VoidCallback? onShareTap;

  const ArticleTitleSectionWidget({
    super.key,
    required this.article,
    this.titleFontSize = 20,
    this.showBookMark = true,
    this.onShareTap,
  });

  Future<void> _handleBookmarkToggle(BuildContext context, WidgetRef ref) async {
    final toggle = ref.read(toggleBookmarkProvider);

    try {
      await toggle(article); // Perform toggle
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to update bookmark'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch bookmark status stream
    final bookmarkStatus =
    ref.watch(isArticleBookmarkedProvider(article.id));

    final isBookmarked = bookmarkStatus.value ?? false;
    final isLoading = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            article.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: titleFontSize,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Author + Actions
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              ClipOval(
                child: Image.asset(
                  'assets/images/author.jpeg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),

              // Author + Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.author ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      article.publishedAt.toArticleDate().toString(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // Bookmark + Share
              if (showBookMark) ...[
                // Bookmark Button
                IconButton(
                  onPressed: isLoading
                      ? null
                      : () => _handleBookmarkToggle(context, ref),
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: isBookmarked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                // Share Button
                IconButton(
                  onPressed: onShareTap,
                  icon: Icon(
                    Icons.share,
                    size: 20,
                    color: theme.colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}


// Preview
@Preview(name: 'Article Title Section')
Widget ArticleTitleSectionPreview() {
  return MaterialApp(
    theme: NewsAppTheme.lightTheme,
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ArticleTitleSectionWidget(
            article: ArticleData.allArticles[1],
            onShareTap: () {
              debugPrint('Share tapped');
            },
          ),
        ),
      ),
    ),
  );
}