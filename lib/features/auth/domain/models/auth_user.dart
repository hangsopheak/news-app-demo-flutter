class AuthUser {
  final String uid;
  final String email;
  final String? displayName;

  AuthUser({
    required this.uid,
    required this.email,
    this.displayName,
  });

  // Convert from Firebase User
  factory AuthUser.fromFirebaseUser(dynamic firebaseUser) {
    return AuthUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
    );
  }
  
}
