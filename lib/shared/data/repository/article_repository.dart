

import 'package:news_app_demo_flutter/shared/data/local/bookmark_service.dart';
import 'package:news_app_demo_flutter/shared/data/remote/article_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

/// Repository for article operations
/// Provides clean API and error handling for article data
class ArticleRepository {
  final ArticleService _articleService;
  final BookmarkService _bookmarkService;

  ArticleRepository({
    ArticleService? articleService,
    required BookmarkService bookmarkService,
  })  : _articleService = articleService ?? ArticleService(),
        _bookmarkService = bookmarkService;

  /// Get articles with optional filters
  Future<List<Article>> getArticles({
    bool? isFeatured,
    bool? isLatest,
    bool? isBreaking,
    bool? isBookmarked,
    int? categoryId,
  }) async {
    try {
      return await _articleService.getArticles(
        isFeatured: isFeatured,
        isLatest: isLatest,
        isBreaking: isBreaking,
        isBookmarked: isBookmarked,
        categoryId: categoryId,
      );
    } catch (e) {
      print('ArticleRepository.getArticles Error: $e');
      throw Exception('Failed to fetch articles: $e');
    }
  }

  /// Get single article by ID
  Future<Article> getArticleById(int id) async {
    try {
      return await _articleService.getArticleById(id);
    } catch (e) {
      print('ArticleRepository.getArticleById Error: $e');
      throw Exception('Failed to fetch article: $e');
    }
  }

  /// Get featured articles
  Future<List<Article>> getFeaturedArticles() async {
    try {
      return await _articleService.getFeaturedArticles();
    } catch (e) {
      print('ArticleRepository.getFeaturedArticles Error: $e');
      throw Exception('Failed to fetch featured articles: $e');
    }
  }

  /// Get latest articles
  Future<List<Article>> getLatestArticles() async {
    try {
      return await _articleService.getLatestArticles();
    } catch (e) {
      print('ArticleRepository.getLatestArticles Error: $e');
      throw Exception('Failed to fetch latest articles: $e');
    }
  }

  /// Get breaking news
  Future<List<Article>> getBreakingNews() async {
    try {
      return await _articleService.getBreakingNews();
    } catch (e) {
      print('ArticleRepository.getBreakingNews Error: $e');
      throw Exception('Failed to fetch breaking news: $e');
    }
  }



  /// Get articles by category
  Future<List<Article>> getArticlesByCategory(int categoryId) async {
    try {
      return await _articleService.getArticlesByCategory(categoryId);
    } catch (e) {
      print('ArticleRepository.getArticlesByCategory Error: $e');
      throw Exception('Failed to fetch articles by category: $e');
    }
  }

  /// Toggle bookmark status
  Future<void> toggleBookmark(Article article) async {
    try {
      return await _bookmarkService.toggleBookmark(article);
    } catch (e) {
      print('ArticleRepository.toggleBookmark Error: $e');
      throw Exception('Failed to toggle bookmark: $e');
    }
  }
  /// Get bookmarked articles
  Future<List<Article>> getBookmarkedArticles() async {
    try {
      return await _bookmarkService.getAllBookmarks();
    } catch (e) {
      print('ArticleRepository.getBookmarkedArticles Error: $e');
      throw Exception('Failed to fetch bookmarked articles: $e');
    }
  }

  /// Check if article is bookmarked (local storage)
  /// Future = one-time fetch
  // Stream = continuous updates
  // Bookmark status is something that can change, so stream fits perfectly
  Stream<bool> watchArticleBookmarkStatus(int articleId) {
    return _bookmarkService.watchArticleBookmarkStatus(articleId);
  }


}