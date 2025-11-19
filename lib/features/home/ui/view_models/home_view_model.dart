import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/providers.dart';
import 'home_ui_state.dart';

/// ViewModel for Home Screen (MVVM pattern)
class HomeViewModel extends Notifier<HomeUiState> {
  @override
  HomeUiState build() {
    // Auto-load data when ViewModel is first created
    print('HomeViewModel - build() called');
    Future.microtask(() => loadHomeData());
    return const HomeUiState();
  }

  /// Load all home screen data (breaking, featured, latest)
  Future<void> loadHomeData() async {

    // Prevent loading if already loading
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(articleRepositoryProvider);
      // Load all article types in parallel
      final results = await Future.wait([
        repository.getBreakingNews(),
        repository.getFeaturedArticles(),
        repository.getLatestArticles(),
      ]);

      state = state.copyWith(
        isLoading: false,
        breakingArticles: results[0],
        featuredArticles: results[1],
        latestArticles: results[2],
      );

    } catch (e) {

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }


}

/// Provider for HomeViewModel
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeUiState>(() {
  return HomeViewModel();
});