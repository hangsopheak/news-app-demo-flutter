import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/core/utils/date_format_util.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

class ArticleTitleSectionWidget extends StatelessWidget {
  final Article article;
  final double titleFontSize;
  final bool showBookMark;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;

  const ArticleTitleSectionWidget({
    super.key,
    required this.article,
    this.titleFontSize = 20,
    this.showBookMark = true,
    this.onBookmarkTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/author.jpeg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 30,
                      height: 30,
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 16),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.author ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      article.publishedAt.toArticleStyle().toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              if (showBookMark) ...[
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Icon(
                    article.isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: article.isBookMarked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
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
              ],
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
            onBookmarkTap: () {
              debugPrint('Bookmark tapped');
            },
            onShareTap: () {
              debugPrint('Share tapped');
            },
          ),
        ),
      ),
    ),
  );
}