import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/ui/view_models/article_list_by_flag_view_model.dart';
import 'package:news_app_demo_flutter/shared/data/local/article_data.dart';
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
    
    final articleByFlagViewModel = ref.watch(articleByFlagViewModelProvider);
    ref.read(articleByFlagViewModelProvider.notifier).loadArticlesByFlag(articleFlagId);
    return RefreshIndicator(
      onRefresh: () => ref.read(articleByFlagViewModelProvider.notifier).loadArticlesByFlag(articleFlagId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(flagDescription),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: articleByFlagViewModel.articles.isEmpty
            ? const Center(
          child: Text('No articles found'),
        )
            : ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: articleByFlagViewModel.articles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return ArticleCardVerticalWidget(
              article: articleByFlagViewModel.articles[index],
              onTap: () => _onArticleTap(context, articleByFlagViewModel.articles[index]),
            );
          },
        ),
      ),
    );
  }
}