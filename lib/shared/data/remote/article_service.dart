

import 'package:news_app_demo_flutter/core/utils/network/api_client.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

/// Service for article-related API operations
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
    try {
      final Map<String, dynamic> queryParams = {};

      if (expandCategory) queryParams['_expand'] = 'category';
      if (isFeatured != null) queryParams['isFeatured'] = isFeatured.toString();
      if (isLatest != null) queryParams['isLatest'] = isLatest.toString();
      if (isBreaking != null) queryParams['isBreaking'] = isBreaking.toString();
      if (isBookmarked != null) queryParams['isBookmarked'] = isBookmarked.toString();
      if (categoryId != null) queryParams['categoryId'] = categoryId.toString();

      final response = await _apiClient.get<List<dynamic>>(
        '/articles',
        queryParameters: queryParams,
      );

      return response
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('ArticleService.getArticles Error: $e');
      rethrow;
    }
  }

  /// Get single article by ID
  Future<Article> getArticleById(int id, {bool expandCategory = true}) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (expandCategory) queryParams['_expand'] = 'category';

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/articles/$id',
        queryParameters: queryParams,
      );

      return Article.fromJson(response);
    } catch (e) {
      print('ArticleService.getArticleById Error: $e');
      rethrow;
    }
  }

  /// Get featured articles
  Future<List<Article>> getFeaturedArticles() async {
    return getArticles(isFeatured: true);
  }

  /// Get latest articles
  Future<List<Article>> getLatestArticles() async {
    return getArticles(isLatest: true);
  }

  /// Get breaking news
  Future<List<Article>> getBreakingNews() async {
    return getArticles(isBreaking: true);
  }

  /// Get bookmarked articles
  Future<List<Article>> getBookmarkedArticles() async {
    return getArticles(isBookmarked: true);
  }

  /// Get articles by category
  Future<List<Article>> getArticlesByCategory(int categoryId) async {
    return getArticles(categoryId: categoryId);
  }

  /// Create new article
  Future<Article> createArticle(Article article) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/articles',
        body: article.toJson(),
      );
      return Article.fromJson(response);
    } catch (e) {
      print('ArticleService.createArticle Error: $e');
      rethrow;
    }
  }

  /// Update existing article
  Future<Article> updateArticle(int id, Article article) async {
    try {
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/articles/$id',
        body: article.toJson(),
      );
      return Article.fromJson(response);
    } catch (e) {
      print('ArticleService.updateArticle Error: $e');
      rethrow;
    }
  }

  /// Delete article
  Future<void> deleteArticle(int id) async {
    try {
      await _apiClient.delete('/articles/$id');
    } catch (e) {
      print('ArticleService.deleteArticle Error: $e');
      rethrow;
    }
  }

  /// Toggle bookmark status
  Future<Article> toggleBookmark(Article article) async {
    final updatedArticle = article.copyWith(
      isBookMarked: !article.isBookMarked,
    );
    return updateArticle(article.id, updatedArticle);
  }
}