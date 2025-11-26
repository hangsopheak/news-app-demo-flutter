import 'package:news_app_demo_flutter/core/utils/network/api_client.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';

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