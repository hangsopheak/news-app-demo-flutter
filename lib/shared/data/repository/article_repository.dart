import 'package:news_app_demo_flutter/shared/data/remote/article_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'article_repository.g.dart';



@Riverpod(keepAlive: true)
ArticleRepository articleRepository(Ref ref) {
  final service = ref.watch(articleServiceProvider);
  return ArticleRepository(articleService: service);
}

class ArticleRepository {
  final ArticleService _articleService;


  ArticleRepository({required ArticleService articleService})
      : _articleService = articleService;

  /// Get articles with optional filters
  Future<List<Article>> getArticles({
    bool? isFeatured,
    bool? isLatest,
    bool? isBreaking,
    bool? isBookmarked,
    int? categoryId,
  }) {

    return _articleService.getArticles(
      isFeatured: isFeatured,
      isLatest: isLatest,
      isBreaking: isBreaking,
      isBookmarked: isBookmarked,
      categoryId: categoryId,
    );
  }

  /// Get single article by ID
  Future<Article> getArticleById(int id) =>
      _articleService.getArticleById(id);

  Future<List<Article>> getFeaturedArticles() =>
      _articleService.getFeaturedArticles();

  Future<List<Article>> getLatestArticles() =>
      _articleService.getLatestArticles();

  Future<List<Article>> getBreakingNews() =>
      _articleService.getBreakingNews();

  Future<List<Article>> getArticlesByCategory(int categoryId) =>
      _articleService.getArticlesByCategory(categoryId);

}