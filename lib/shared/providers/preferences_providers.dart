import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'preferences_providers.g.dart';

// ============================================================================
// 1. ASYNC SHARED PREFERENCES PROVIDER (Guaranteed Initialization)
// ============================================================================

/// Asynchronously loads and exposes the SharedPreferences instance.
/// This MUST be an AsyncValue<SharedPreferences> to ensure it's ready
/// before any dependent providers try to read it.
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}


// ============================================================================
// 2. THEME MODE NOTIFIER
// ============================================================================

/// Manages the persistence and state of the app's theme mode.
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _themeKey = 'theme_mode';

  /// Initializer: Called when the provider is first accessed.
  /// It reads the SharedPreferences dependency and returns the initial state.
  @override
  ThemeMode build() {
    // 1. Watch the AsyncProvider and wait for data to be ready.
    final prefsAsync = ref.watch(sharedPreferencesProvider);

    // If SharedPreferences is still loading, return a default value (e.g., system)
    if (prefsAsync.isLoading || prefsAsync.hasError) {
      return ThemeMode.system;
    }

    // Get the successfully loaded SharedPreferences instance
    final prefs = prefsAsync.value!;

    final saved = prefs.getString(_themeKey);

    if (saved == 'dark') {
      return ThemeMode.dark;
    } else if (saved == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }


  /// Public method to update the theme mode and save it to storage.
  Future<void> setMode(ThemeMode mode) async {
    // 1. Get the current SharedPreferences instance (it MUST be ready by now)
    final prefs = ref.read(sharedPreferencesProvider).requireValue;

    // 2. Update the state immediately for UI refresh
    state = mode;

    // 3. Save to storage
    await prefs.setString(
      _themeKey,
      mode == ThemeMode.dark
          ? 'dark'
          : mode == ThemeMode.light
          ? 'light'
          : 'system',
    );
  }
}

// ============================================================================
// 3. LANGUAGE / LOCALE NOTIFIER
// ============================================================================

/// Manages the persistence and state of the app's locale.
@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  static const _langKey = 'app_language';

  @override
  Locale build() {
    // 1. Watch the AsyncProvider and wait for data to be ready.
    final prefsAsync = ref.watch(sharedPreferencesProvider);

    if (prefsAsync.isLoading || prefsAsync.hasError) {
      // Default locale while loading or if initialization failed
      return const Locale('en');
    }

    final prefs = prefsAsync.value!;
    final code = prefs.getString(_langKey);

    if (code != null && code.isNotEmpty) {
      return Locale(code);
    }

    // Set default locale (e.g., English)
    return const Locale('en');
  }


  /// Public method to update the locale and save it to storage.
  Future<void> setLocale(Locale newLocale) async {
    // 1. Get the SharedPreferences instance
    final prefs = ref.read(sharedPreferencesProvider).requireValue;

    // 2. Update the state
    state = newLocale;

    // 3. Save to storage
    await prefs.setString(_langKey, newLocale.languageCode);
  }
}