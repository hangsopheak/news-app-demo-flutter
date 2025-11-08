import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/concept_demo/widgets/demo_card.dart';

import 'async_notifier_demo_screen.dart';
import 'notifier_demo_screen.dart';
import 'provider_demo_screen.dart';

class RiverpodHomeScreen extends StatelessWidget {
  const RiverpodHomeScreen({super.key});

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
          Text(
            '📚 Basic Riverpod 3.0 Concepts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Learn the 3 main provider types in Riverpod 3.0',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          DemoCard(
            title: '1. Provider',
            subtitle: 'Read-only values (DI)',
            description: 'Perfect for configs, repositories, services',
            icon: Icons.settings,
            color: Colors.blue,
            onTap: () => _navigate(context, const ProviderDemoScreen()),
          ),
          const SizedBox(height: 12),
          DemoCard(
            title: '2. Notifier',
            subtitle: 'Complex mutable state',
            description: 'For business logic, validation, complex operations',
            icon: Icons.add_shopping_cart,
            color: Colors.purple,
            onTap: () => _navigate(context, const NotifierDemoScreen()),
          ),
          const SizedBox(height: 12),
          DemoCard(
            title: '3. AsyncNotifier',
            subtitle: 'Async state (API, DB)',
            description: 'Handles loading/error/data states automatically',
            icon: Icons.cloud,
            color: Colors.green,
            onTap: () => _navigate(context, const AsyncNotifierDemoScreen()),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}