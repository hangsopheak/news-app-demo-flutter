
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

class UserProfile extends AsyncNotifier<User> {
  @override
  Future<User> build() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    return User(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
    );
  }

  Future<void> updateName(String newName) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));

      return User(
        id: '1',
        name: newName,
        email: 'john@example.com',
      );
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));

      return User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
      );
    });
  }
}

