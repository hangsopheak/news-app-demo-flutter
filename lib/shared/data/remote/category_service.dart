import 'package:news_app_demo_flutter/core/utils/network/api_client.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_service.g.dart';

@Riverpod(keepAlive: true)
CategoryService categoryService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CategoryService(apiClient: apiClient);
}

class CategoryService {
  final ApiClient _apiClient;

  CategoryService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<Category>> getCategories() async {
    final response = await _apiClient.get<List<dynamic>>('/categories');

    return response
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }

}