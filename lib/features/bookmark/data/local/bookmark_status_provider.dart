
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/bookmark/data/repository/bookmark_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_status_provider.g.dart';

// The generator sees this extra argument and automatically creates a "Family" provider for you.
@riverpod
Stream<bool> isBookmarked(Ref ref, int articleId) {
  return ref.watch(bookmarkRepositoryProvider).watchArticleBookmarkStatus(articleId);
}