import 'package:news_app_demo_flutter/core/utils/network/api_client.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';


/// Service for category-related API operations
class CategoryService {
  final ApiClient _apiClient;

  CategoryService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  /// Get all categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get<List<dynamic>>('/categories');

      return response
          .map((json) => Category.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('CategoryService.getCategories Error: $e');
      rethrow;
    }
  }

  /// Get single category by ID
  Future<Category> getCategoryById(int id) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>('/categories/$id');
      return Category.fromJson(response);
    } catch (e) {
      print('CategoryService.getCategoryById Error: $e');
      rethrow;
    }
  }

  /// Create new category
  Future<Category> createCategory(Category category) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/categories',
        body: category.toJson(),
      );
      return Category.fromJson(response);
    } catch (e) {
      print('CategoryService.createCategory Error: $e');
      rethrow;
    }
  }

  /// Update existing category
  Future<Category> updateCategory(int id, Category category) async {
    try {
      final response = await _apiClient.put<Map<String, dynamic>>(
        '/categories/$id',
        body: category.toJson(),
      );
      return Category.fromJson(response);
    } catch (e) {
      print('CategoryService.updateCategory Error: $e');
      rethrow;
    }
  }

  /// Delete category
  Future<void> deleteCategory(int id) async {
    try {
      await _apiClient.delete('/categories/$id');
    } catch (e) {
      print('CategoryService.deleteCategory Error: $e');
      rethrow;
    }
  }
}