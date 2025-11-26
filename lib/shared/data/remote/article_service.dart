import 'package:news_app_demo_flutter/core/utils/network/api_client.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class ArticleService {
  final ApiClient _apiClient;

  ArticleService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// Get articles with optional filters
  Future<List<Article>> getArticles({
    bool? isFeatured,
    bool? isLatest,
    bool? isBreaking,
    bool? isBookmarked,
    int? categoryId,
    bool expandCategory = true,
  }) async {
    // 1. Build the parameters cleanly
    final qParams = {
      if (expandCategory) '_expand': 'category',
      if (isFeatured != null) 'isFeatured': '$isFeatured',
      if (isLatest != null) 'isLatest': '$isLatest',
      if (isBreaking != null) 'isBreaking': '$isBreaking',
      if (isBookmarked != null) 'isBookmarked': '$isBookmarked',
      if (categoryId != null) 'categoryId': '$categoryId',
    };

    // 2. Call ApiClient
    final response = await _apiClient.get<List<dynamic>>(
      '/articles',
      params: qParams,
    );

    // 3. Map to objects
    return response
        .map((json) => Article.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Get single article by ID
  Future<Article> getArticleById(int id, {bool expandCategory = true}) async {
    final qParams = {
      if (expandCategory) '_expand': 'category',
    };

    final response = await _apiClient.get<Map<String, dynamic>>(
      '/articles/$id',
      params: qParams, // Matches ApiClient 'params'
    );

    return Article.fromJson(response);
  }

  Future<List<Article>> getFeaturedArticles() => getArticles(isFeatured: true);

  Future<List<Article>> getLatestArticles() => getArticles(isLatest: true);

  Future<List<Article>> getBreakingNews() => getArticles(isBreaking: true);

  Future<List<Article>> getBookmarkedArticles() => getArticles(isBookmarked: true);

  Future<List<Article>> getArticlesByCategory(int categoryId) =>
      getArticles(categoryId: categoryId);

}