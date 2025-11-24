import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/auth/domain/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

// 1. Generate the Provider
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(firebase_auth.FirebaseAuth.instance);
}

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  // Stream: Maps Firebase User -> Your AuthUser
  Stream<AuthUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return AuthUser.fromFirebaseUser(firebaseUser);
    });
  }

  // Sign Up
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(name);
    // Force reload to ensure display name is available immediately if needed
    await credential.user?.reload();
    return AuthUser.fromFirebaseUser(_firebaseAuth.currentUser!);
  }

  // Login
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthUser.fromFirebaseUser(credential.user!);
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}