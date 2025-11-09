import 'package:news_app_demo_flutter/features/auth/domain/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class AuthRepository {
  final firebase_auth.FirebaseAuth? _providedFirebaseAuth;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _providedFirebaseAuth = firebaseAuth;

  // Lazily return FirebaseAuth.instance so constructing this repository
  // doesn't immediately access Firebase if it hasn't been initialized yet.
  firebase_auth.FirebaseAuth get _firebaseAuth {
    return _providedFirebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  }

  // Get current user (synchronous - from cache)
  AuthUser? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return AuthUser.fromFirebaseUser(firebaseUser);
  }

  // Listen to auth state changes (stream)
  Stream<AuthUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return AuthUser.fromFirebaseUser(firebaseUser);
    });
  }

  // Sign up
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

    return AuthUser(
      uid: credential.user!.uid,
      email: credential.user!.email ?? '',
      displayName: name,
    );
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
