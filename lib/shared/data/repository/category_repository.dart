

import 'package:news_app_demo_flutter/shared/data/remote/category_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';

/// Repository for category operations
/// Provides clean API and error handling for category data
class CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepository({CategoryService? categoryService})
      : _categoryService = categoryService ?? CategoryService();

  /// Get all categories
  Future<List<Category>> getCategories() async {
    try {
      return await _categoryService.getCategories();
    } catch (e) {
      print('CategoryRepository.getCategories Error: $e');
      throw Exception('Failed to fetch categories: $e');
    }
  }

  /// Get single category by ID
  Future<Category> getCategoryById(int id) async {
    try {
      return await _categoryService.getCategoryById(id);
    } catch (e) {
      print('CategoryRepository.getCategoryById Error: $e');
      throw Exception('Failed to fetch category: $e');
    }
  }


}