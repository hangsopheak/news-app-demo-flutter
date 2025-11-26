import 'package:news_app_demo_flutter/shared/data/remote/category_service.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_repository.g.dart';

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) {
  final service = ref.watch(categoryServiceProvider);
  return CategoryRepository(categoryService: service);
}

class CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepository({required CategoryService categoryService})
      : _categoryService = categoryService;

  Future<List<Category>> getCategories() async {
      return _categoryService.getCategories();
  }
}