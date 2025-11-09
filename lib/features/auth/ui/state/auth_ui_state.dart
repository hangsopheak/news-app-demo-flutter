import 'package:news_app_demo_flutter/features/auth/domain/models/auth_user.dart';

class AuthUiState {
  final AuthUser? user;
  final bool isLoading;
  final String? errorMessage;

  AuthUiState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  // Computed properties for UI
  bool get isAuthenticated => user != null;
  bool get hasError => errorMessage != null;

  // Copy with for immutable updates
  AuthUiState copyWith({
    AuthUser? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthUiState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Factory for clearing state
  /*
  In Dart, a factory constructor is a special kind of constructor that does not always create a new instance of a class.
  Instead, it can:
  Return an existing instance, or
  Perform custom initialization logic before creating an object, or
  Return a subclass or a cached object.
   */
  factory AuthUiState.initial() {
    return AuthUiState();
  }

  // Factory for loading state
  factory AuthUiState.loading() {
    return AuthUiState(isLoading: true);
  }

  // Factory for error state
  factory AuthUiState.error(String message) {
    return AuthUiState(errorMessage: message);
  }

  // Factory for authenticated state
  factory AuthUiState.authenticated(AuthUser user) {
    return AuthUiState(user: user);
  }
}