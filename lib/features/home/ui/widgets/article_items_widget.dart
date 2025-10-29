import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/data/local/home_data.dart';
import 'package:news_app_demo_flutter/features/home/ui/widgets/article_card_widget.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

class ArticleItemsWidget extends StatelessWidget {
  const ArticleItemsWidget({super.key, required this.articles});

  final List<Article> articles;
  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: articles.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index < articles.length - 1 ? 12 : 0,
            ),
            child: ArticleCardWidget(article: articles[index], onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: articles[index]),
                ),
              );
            }),
          );
        }
      )
    );
  }
}

@Preview(name: 'Article Items Widget - Horizontal List')
Widget ArticleItemsPreview() {
  return MaterialApp(
    theme: NewsAppTheme.lightTheme,
    home: Scaffold(
      body: SafeArea(
        child: ArticleItemsWidget(
          articles: HomeData.breakingArticles,
        ),
      ),
    ),
  );
}
