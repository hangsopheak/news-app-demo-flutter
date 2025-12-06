// 1. THIS IS MANDATORY
// It tells Dart: "The code for this file continues in bookmark_list_provider.g.dart"
import 'package:news_app_demo_flutter/features/bookmark/data/repository/bookmark_repository.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_list_provider.g.dart';

@riverpod
Future<List<Article>> bookmarkList(Ref ref) {
  // We use the repository we just created
  return ref.watch(bookmarkRepositoryProvider).getBookmarkedArticles();
}