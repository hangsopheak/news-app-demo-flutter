
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_notifier.g.dart';


class User {
  final String name;
  final String email;
  User({required this.name, required this.email});
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<User> build() async {
    // 1. Simulate API Loading
    await Future.delayed(const Duration(seconds: 2));
    // 2. Return Data (AsyncData)
    return User(name: 'John Doe', email: 'john@example.com');
  }

  // Example of an Async Mutation
  Future<void> updateName() async {
    // A. Set state to loading to show spinner
    state = const AsyncLoading();
    // B. Perform async operation and guard against errors
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      return User(name: 'Jane Doe (Updated)', email: 'jane@example.com');
    });
  }
}
