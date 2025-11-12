import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------
// SHARED PREFERENCES PROVIDER
// -----------------------------
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

// -----------------------------
// THEME MODE
// -----------------------------
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    // Default theme
    final prefs = ref.watch(sharedPreferencesProvider);
    final saved = prefs.getString(_themeKey);

    if (saved == 'dark') {
      return ThemeMode.dark;
    } else if (saved == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.light;
    }
  }


  Future<void> setMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    state = mode;

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

// -----------------------------
// LANGUAGE / LOCALE
// -----------------------------
class LanguageNotifier extends Notifier<Locale> {
  static const _langKey = 'app_language';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final code = prefs.getString(_langKey);

    if (code != null && code.isNotEmpty) {
      return Locale(code);
    }
    return const Locale('en');
  }


  Future<void> setLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    state = newLocale;
    await prefs.setString(_langKey, newLocale.languageCode);
  }
}

// -----------------------------
// PROVIDERS
// -----------------------------

final languageProvider =
NotifierProvider<LanguageNotifier, Locale>(LanguageNotifier.new);

final themeModeProvider =
NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);


