import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_title_section_widget.dart';

class ArticleCardVerticalWidget extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  final VoidCallback? onShareTap;

  const ArticleCardVerticalWidget({
    super.key,
    required this.article,
    this.onTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ArticleTitleSectionWidget(
                    article: article,
                    titleFontSize: 16,
                    showBookMark: false,
                    onShareTap: onShareTap,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  width: 130,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 130,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 130,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Preview
@Preview(name: 'Article Card Vertical')
Widget ArticleCardVerticalPreview() {
  return MaterialApp(
    theme: NewsAppTheme.lightTheme,
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ArticleCardVerticalWidget(
            article: ArticleData.allArticles[2],
            onTap: () {
              debugPrint('Article tapped');
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