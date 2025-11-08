import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ============================================================================
// 1. PROVIDER - Read-only values (Dependency Injection)
// ============================================================================

// Simple value provider
final appNameProvider = Provider<String>((ref) {
  return 'Riverpod 3.0 Demo';
});

// Config object provider
final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig(
    apiUrl: 'https://api.example.com',
    timeout: 30,
  );
});

// Service provider that depends on other providers
final apiServiceProvider = Provider<ApiService>((ref) {
  final config = ref.watch(appConfigProvider);
  return ApiService(config);
});

// Models
class AppConfig {
  final String apiUrl;
  final int timeout;

  AppConfig({required this.apiUrl, required this.timeout});
}

class ApiService {
  final AppConfig config;
  ApiService(this.config);

  String getEndpoint() => '${config.apiUrl}/users';
}



class ProviderDemoScreen extends ConsumerWidget {
  const ProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(appNameProvider);
    final config = ref.watch(appConfigProvider);
    final service = ref.watch(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is Provider?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Provider exposes read-only values for dependency injection. '
                  'Perfect for configs, repositories, and services.',
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                title: const Text('App Name'),
                subtitle: Text(appName),
                leading: const Icon(Icons.text_fields),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('App Config'),
                subtitle: Text('API: ${config.apiUrl}\nTimeout: ${config.timeout}s'),
                leading: const Icon(Icons.settings),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('API Service'),
                subtitle: Text('Endpoint: ${service.getEndpoint()}'),
                leading: const Icon(Icons.cloud),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
