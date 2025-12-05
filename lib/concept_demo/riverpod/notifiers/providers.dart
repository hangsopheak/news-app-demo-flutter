import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'; // Import this if 'Ref' is undefined
// Ensure this line is present and matches your generated file name!
part 'providers.g.dart';

// Use command flutter pub run build_runner build --delete-conflicting-outputs
// --- 1. Simple Value Provider ---
@riverpod
String appName(Ref ref) {
  return 'Riverpod 3.0 Demo';
}

// --- 2. Config Object Provider (Injects a fixed object)
@riverpod
AppConfig appConfig(Ref ref) {
  return const AppConfig(
    apiUrl: 'https://api.example.com',
    timeout: 30,
  );
}

// --- 3. Service Provider (Depends on a Provider) ---
@riverpod
ApiService apiService(Ref ref) {
  // We use ref.read() here to get the dependency ONCE.
  final config = ref.read(appConfigProvider);
  return ApiService(config);
}

// --- Models ---
class AppConfig {
  final String apiUrl;
  final int timeout;
  const AppConfig({required this.apiUrl, required this.timeout});
}

class ApiService {
  final AppConfig config;
  const ApiService(this.config);

  String getEndpoint() => '${config.apiUrl}/users';
}