import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/auth/data/repository/auth_repository.dart';
import 'package:news_app_demo_flutter/features/auth/domain/models/auth_user.dart';
import 'package:news_app_demo_flutter/features/auth/ui/state/auth_ui_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthNotifier extends Notifier<AuthUiState> {
  late final AuthRepository _repository;
  StreamSubscription? _authSubscription;

  @override
  AuthUiState build() {
    _repository = ref.watch(authRepositoryProvider);

    // Cancel previous listener if any
    _authSubscription?.cancel();

    // Initial synchronous state
    final currentUser = _repository.getCurrentUser();
    final initialState = currentUser != null
        ? AuthUiState.authenticated(currentUser)
        : AuthUiState.initial();

    // 🔥 Delay auth listener setup to avoid race condition with login()
    Future.microtask(() {
      _authSubscription = _repository.authStateChanges().listen((user) {
        print('Auth state changed - user: ${user?.email}'); // Debug

        if (user != null) {
          state = AuthUiState.authenticated(AuthUser.fromFirebaseUser(user));
        } else {
          // Only reset to initial if not in error state
          if (!state.hasError) {
            state = AuthUiState.initial();
          }
        }
      });
    });

    return initialState;
  }

  // --------------------------
  // LOGIN
  // --------------------------
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = AuthUiState.loading();
    try {
      final user = await _repository.login(email: email, password: password);
      // Don’t rely on stream yet; set immediate state
      state = AuthUiState.authenticated(user);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = AuthUiState.error(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      state = AuthUiState.error('An unexpected error occurred');
      return false;
    }
  }

  // --------------------------
  // SIGNUP
  // --------------------------
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = AuthUiState.loading();
    try {
      final user = await _repository.signUp(
        email: email,
        password: password,
        name: name,
      );
      state = AuthUiState.authenticated(user);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = AuthUiState.error(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      state = AuthUiState.error('An unexpected error occurred');
      return false;
    }
  }

  // --------------------------
  // LOGOUT
  // --------------------------
  Future<void> logout() async {
    try {
      await _repository.logout();
      state = AuthUiState.initial();
    } catch (e) {
      state = AuthUiState.error(e.toString());
    }
  }

  // --------------------------
  // CLEANUP
  // --------------------------
  @override
  void dispose() {
    _authSubscription?.cancel();
  }

  // --------------------------
  // ERROR MESSAGES
  // --------------------------
  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'invalid-credential':
        return 'Invalid email or password';
      default:
        return 'Authentication error: $code';
    }
  }
}

// Provider
final authNotifierProvider =
NotifierProvider<AuthNotifier, AuthUiState>(AuthNotifier.new);
