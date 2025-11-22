import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/bookmark/ui/view_models/bookmark_ui_state.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';

class BookmarkViewModel extends Notifier<BookmarkUiState> {

  @override
  BookmarkUiState build() {
    return const BookmarkUiState();
  }

  Future<void> loadBookmarkArticles() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(articleRepositoryProvider);
      List<Article> articles = await repository.getBookmarkedArticles();
      state = state.copyWith(
        isLoading: false,
        articles: articles
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

}

/// Provider for ArticleByFlagViewModel
final bookmarkViewModelProvider =
NotifierProvider<BookmarkViewModel, BookmarkUiState>(() {
  return BookmarkViewModel();
});