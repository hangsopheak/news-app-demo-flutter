import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'package:news_app_demo_flutter/shared/data/repository/category_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_notifiers.g.dart';

// -----------------------------------------------------------------------------
// 1. Selected Category State (Synchronous)
// -----------------------------------------------------------------------------
@riverpod
class SelectedCategoryNotifier extends _$SelectedCategoryNotifier {
  @override
  int? build() {
    return null;
  }

  void select(int? categoryId) {
    state = categoryId;
  }
}

// -----------------------------------------------------------------------------
// 2. Categories Data Provider
// -----------------------------------------------------------------------------
@riverpod
Future<List<Category>> exploreCategories(Ref ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategories();
}

// -----------------------------------------------------------------------------
// 3. Articles Data Provider (Dependent on Selection)
// -----------------------------------------------------------------------------
@riverpod
Future<List<Article>> exploreArticles(Ref ref) async {
  final repository = ref.watch(articleRepositoryProvider);

  // We watch the selection provider.
  // Whenever 'selectedCategoryProvider' changes, this function RE-RUNS automatically.
  final selectedCategoryId = ref.watch(selectedCategoryProvider);

  if (selectedCategoryId == null) {
    return repository.getArticles();
  } else {
    return repository.getArticlesByCategory(selectedCategoryId);
  }
}