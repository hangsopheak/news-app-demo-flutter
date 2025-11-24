import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/concept_demo/riverpod/notifiers/providers.dart';


class ProviderDemoScreen extends ConsumerWidget {
  const ProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. WATCH the providers to get their values
    final appName = ref.watch(appNameProvider);
    final config = ref.watch(appConfigProvider);
    final service = ref.watch(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('1. Provider (DI)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'The "Provider" type is for read-only values. It creates the graph for Dependency Injection.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 20),

          // --- 1. Simple Value ---
          const _Header('1. Simple Value'),
          _InfoCard(
            icon: Icons.label,
            label: 'App Name',
            value: appName,
          ),

          // --- 2. Object ---
          const _Header('2. Configuration Object'),
          _InfoCard(
            icon: Icons.settings,
            label: 'Config',
            value: 'API: ${config.apiUrl}\nTimeout: ${config.timeout}s',
          ),

          // --- 3. Dependency Injection ---
          const _Header('3. Service (Injects Config)'),
          _InfoCard(
            icon: Icons.cloud_done,
            label: 'Api Service Endpoint',
            value: service.getEndpoint(), // Data derived from the injected config
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Helper Widgets
// ============================================================================

class _Header extends StatelessWidget {
  final String title;
  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(label, style: const TextStyle(fontSize: 13)),
        subtitle: Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87
          ),
        ),
      ),
    );
  }
}