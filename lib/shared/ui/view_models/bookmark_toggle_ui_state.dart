/// UI State for bookmark toggle operations
class BookmarkToggleUiState {
  final bool isLoading;
  final String? error;

  const BookmarkToggleUiState({
    this.isLoading = false,
    this.error,
  });

  BookmarkToggleUiState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return BookmarkToggleUiState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}