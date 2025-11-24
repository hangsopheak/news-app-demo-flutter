// lib/concept_demo/riverpod_home_screen.dart
import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/concept_demo/riverpod/provider_demo_screen.dart';
import 'async_notifier_demo_screen.dart';
import 'notifier_demo_screen.dart';
import 'widgets/demo_card.dart';
// ... import screen files

class RiverpodHomeScreen extends StatelessWidget {
  const RiverpodHomeScreen({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 3.0 Demos'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 2. The Provider List
          const Text(
            'The 3 Pillars of State Management:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // --- 1. Provider Demo ---
          DemoCard(
            title: '1. Provider (Read-only)',
            subtitle: 'Purpose: Providing static or immutable objects.\nUse Cases: Config objects, API Clients, Repositories, and service injection.',
            onTap: () => _navigate(context, const ProviderDemoScreen()),
          ),
          const SizedBox(height: 16),

          // --- 2. Notifier Demo ---
          DemoCard(
            title: '2. Notifier (Mutable State)',
            subtitle: 'Purpose: Managing complex synchronous state changes.\nUse Cases: Shopping Cart logic, list management, form validation, and complex business logic.',
            onTap: () => _navigate(context, const NotifierDemoScreen()),
          ),
          const SizedBox(height: 16),

          // --- 3. AsyncNotifier Demo ---
          DemoCard(
            title: '3. AsyncNotifier (Async State)',
            subtitle: 'Purpose: Handling asynchronous state and its lifecycle (Loading, Error, Data).\nUse Cases: API data fetching, database operations, and user profile loading.',
            onTap: () => _navigate(context, const AsyncNotifierDemoScreen()),
          ),
        ],
      ),
    );
  }
}