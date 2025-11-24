import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifiers/user_profile_notifier.dart';

class AsyncNotifierDemoScreen extends ConsumerWidget {
  const AsyncNotifierDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. WATCH the state
    // Provider name is now userProfileProvider (matches UserProfile class)
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('3. AsyncNotifier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            // Invalidate forces the provider to dispose and fetch data again
            onPressed: () => ref.invalidate(userProfileProvider),
          ),
        ],
      ),
      body: Center(
        // 2. HANDLE STATES
        child: userAsync.when(
          // Force loading spinner to show during refresh
          skipLoadingOnRefresh: false,

          // State A: Loading
          loading: () => const CircularProgressIndicator(),

          // State B: Error
          error: (error, stack) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: const Text('Retry'),
              ),
            ],
          ),

          // State C: Data (Success)
          data: (user) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              Text(
                user.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                // Correctly calls the .notifier of userProfileProvider
                onPressed: () =>
                    ref.read(userProfileProvider.notifier).updateName(),
                icon: const Icon(Icons.edit),
                label: const Text('Update Name'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}