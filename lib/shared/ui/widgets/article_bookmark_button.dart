import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/bookmark/data/local/bookmark_status_provider.dart';
import 'package:news_app_demo_flutter/features/bookmark/data/repository/bookmark_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class ArticleBookmarkButton extends ConsumerWidget {
  final Article article;

  const ArticleBookmarkButton({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // 1. WATCH: Listen to the Hive Stream for this specific ID
    // The provider family expects an 'int', so we pass article.id
    final bookmarkAsync = ref.watch(isBookmarkedProvider(article.id));

    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () {
        // 2. READ: Toggle the bookmark in the repository
        ref.read(bookmarkRepositoryProvider).toggleBookmark(article);
      },
      // 3. RENDER: Handle the stream states
      icon: bookmarkAsync.when(
        data: (isBookmarked) => Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          size: 20,
          color: isBookmarked
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
        loading: () => Icon(
          Icons.bookmark_border,
          size: 20,
          color: theme.colorScheme.onSurface.withOpacity(0.3),
        ),
        error: (_, __) => const Icon(Icons.error_outline, size: 20, color: Colors.red),
      ),
    );
  }
}