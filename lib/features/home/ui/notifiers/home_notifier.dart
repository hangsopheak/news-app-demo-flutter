import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:news_app_demo_flutter/shared/data/repository/article_repository.dart';
import 'home_ui_state.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {

  /// build() is the initialization logic.
  /// Riverpod automatically sets the state to 'loading' while this Future runs.
  @override
  Future<HomeUiState> build() async {
    return _fetchData();
  }

  /// Helper to fetch all data in parallel
  Future<HomeUiState> _fetchData() async {
    // 1. Get the repository (Riverpod injects it)
    final repository = ref.watch(articleRepositoryProvider);

    // 2. Run all API calls at the same time (Performance optimization)
    final results = await Future.wait([
      repository.getBreakingNews(),
      repository.getFeaturedArticles(),
      repository.getLatestArticles(),
    ]);

    // 3. Return the Data.
    // Riverpod automatically wraps this in AsyncValue.data()
    return HomeUiState(
      breakingArticles: results[0],
      featuredArticles: results[1],
      latestArticles: results[2],
    );
  }

  /// Pull-to-Refresh logic
  Future<void> refresh() async {
    // In Riverpod 3.0 This triggers build() to run again.
    ref.invalidateSelf();
    // Use 'future' to await the completion (so the UI spinner knows when to stop)
    await future;
  }
}