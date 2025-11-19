import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/shared/data/remote/article_service.dart';
import 'package:news_app_demo_flutter/shared/data/remote/category_service.dart';
import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'package:news_app_demo_flutter/shared/data/repository/category_repository.dart';

import 'core/utils/network/api_client.dart';

/// Global providers for dependency injection
/// Located at lib level to avoid circular dependencies

/// Provider for ApiClient singleton
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Provider for ArticleService
final articleServiceProvider = Provider<ArticleService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ArticleService(apiClient: apiClient);
});

/// Provider for CategoryService
final categoryServiceProvider = Provider<CategoryService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CategoryService(apiClient: apiClient);
});

/// Provider for ArticleRepository
final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final articleService = ref.watch(articleServiceProvider);
  return ArticleRepository(articleService: articleService);
});

/// Provider for CategoryRepository
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final categoryService = ref.watch(categoryServiceProvider);
  return CategoryRepository(categoryService: categoryService);
});
