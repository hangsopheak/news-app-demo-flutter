import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/auth/data/auth_repository.dart';
import 'package:news_app_demo_flutter/features/auth/domain/models/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {

  /// The build method returns a Stream. This means the "Source of Truth"
  /// is directly from Firebase. We don't store the user manually;
  /// we just listen to what Firebase tells us.
  @override
  Stream<AuthUser?> build() {
    return ref.watch(authRepositoryProvider).authStateChanges();
  }

  // --------------------------
  // LOGIN
  // --------------------------
  Future<void> login({required String email, required String password}) async {
    // 1. Set Loading: We manually set this to show the spinner immediately.
    state = const AsyncLoading();

    try {
      // 2. Trigger Action: Tell Firebase to sign in.
      await ref.read(authRepositoryProvider).login(email: email, password: password);

      // 3. Wait for Stream: We DO NOT manually set state to success here.
      // Why? Because the `build` method is already listening to Firebase.
      // Once Firebase finishes, it will emit the new user automatically.
      // This prevents "Fake Success" states where the app thinks it's logged in
      // but the connection actually dropped.

    } catch (e, stack) {
      // 4. Handle Errors: If the request fails, we show a readable message.
      state = AsyncError(_getReadableErrorMessage(e), stack);
    }
  }

  // --------------------------
  // SIGNUP
  // --------------------------
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();

    try {
      await ref.read(authRepositoryProvider).signUp(
        email: email,
        password: password,
        name: name,
      );
      // Success is handled by the stream automatically.
    } catch (e, stack) {
      state = AsyncError(_getReadableErrorMessage(e), stack);
    }
  }

  // --------------------------
  // LOGOUT
  // --------------------------
  Future<void> logout() async {
    // We don't need a try/catch for logout usually, but it's good practice.
    // Calling logout causes the Firebase Stream to emit 'null',
    // which automatically updates our state to "Logged Out".
    await ref.read(authRepositoryProvider).logout();
  }

  // --------------------------
  // ERROR PARSING
  // --------------------------
  /// Converts complex Firebase error codes into user-friendly strings.
  String _getReadableErrorMessage(Object error) {
    if (error is firebase_auth.FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
        case 'invalid-email':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered.';
        case 'weak-password':
          return 'Password is too weak. Try a longer one.';
        case 'invalid-credential':
          return 'Invalid email or password.'; // Common for newer Firebase versions
        case 'network-request-failed':
          return 'Please check your internet connection.';
        default:
          return 'Authentication failed. (${error.code})';
      }
    }
    // Fallback for non-Firebase errors
    return 'An unexpected error occurred. Please try again.';
  }
}