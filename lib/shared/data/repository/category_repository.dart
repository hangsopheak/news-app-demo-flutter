import 'package:news_app_demo_flutter/shared/data/remote/category_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';

/// Repository for category operations
/// Provides clean API and error handling for category data
class CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepository({CategoryService? categoryService})
      : _categoryService = categoryService ?? CategoryService();

  Future<List<Category>> getCategories() async {
      return _categoryService.getCategories();
  }
}