import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

import 'bookmark_toggle_ui_state.dart';

class BookmarkToggleViewModel extends Notifier<BookmarkToggleUiState> {
  @override
  BookmarkToggleUiState build() {
    return const BookmarkToggleUiState();
  }

  /// Toggle bookmark for an article
  Future<void> toggleBookmark(Article article) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(articleRepositoryProvider);
      await repository.toggleBookmark(article);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }



  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for BookmarkToggleViewModel
final bookmarkToggleViewModelProvider =
NotifierProvider<BookmarkToggleViewModel, BookmarkToggleUiState>(() {
  return BookmarkToggleViewModel();
});

/// Family provider to watch bookmark status for specific article
/// This rebuilds the widget when bookmark status changes
final isArticleBookmarkedProvider = StreamProvider.family<bool, int>((ref, articleId) {
  final repository = ref.watch(articleRepositoryProvider);
  return repository.watchArticleBookmarkStatus(articleId);
});