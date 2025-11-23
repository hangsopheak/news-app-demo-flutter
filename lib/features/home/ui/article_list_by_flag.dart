import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/article/ui/article_detail_screen.dart';
import 'package:news_app_demo_flutter/features/home/ui/view_models/article_list_by_flag_view_model.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/ui/widgets/article_card_vertical_widget.dart';

class ArticleListByFlagScreen extends ConsumerStatefulWidget {
  final int articleFlagId;
  final String flagDescription;

  const ArticleListByFlagScreen({
    super.key,
    required this.articleFlagId,
    required this.flagDescription,
  });

  @override
  ConsumerState<ArticleListByFlagScreen> createState() => _ArticleListByFlagScreenState();
}

class _ArticleListByFlagScreenState extends ConsumerState<ArticleListByFlagScreen> {
  @override
  void initState() {
    super.initState();
    // Load articles after the widget tree is built
    Future.microtask(() {
      ref.read(articleByFlagViewModelProvider.notifier).loadArticlesByFlag(widget.articleFlagId);
    });
  }

  void _onArticleTap(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articleByFlagViewModel = ref.watch(articleByFlagViewModelProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(articleByFlagViewModelProvider.notifier).loadArticlesByFlag(widget.articleFlagId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.flagDescription),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: articleByFlagViewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : articleByFlagViewModel.error != null
            ? Center(child: Text('Error: ${articleByFlagViewModel.error}'))
            : articleByFlagViewModel.articles.isEmpty
            ? const Center(child: Text('No articles found'))
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

