
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/onboarding/ui/onboarding_screen.dart';
import 'package:news_app_demo_flutter/features/onboarding/utils/onboarding_util.dart';
import 'package:news_app_demo_flutter/main_screen.dart';
import 'package:news_app_demo_flutter/routes/app_routes.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/providers/app_setting_provider.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/article/ui/article_detail_screen.dart';
import 'features/auth/ui/notifier/auth_notifier.dart';
import 'features/auth/ui/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'l10n/app_localizations.dart';


/*
Configure Firebase
# Install firebase-tools
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# loginÍ
firebase login

# Configure Firebase (auto-setup)
flutterfire configure --project=news-flutter-app-f2a2a
 */


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
     ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MainApp(),
    ),
  );
}


class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(languageProvider), // reactive with Riverpod
      themeMode: ref.watch(themeModeProvider),
      theme: NewsAppTheme.lightTheme,
      darkTheme: NewsAppTheme.darkTheme,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.articleDetail) {
          final article = settings.arguments as Article;
          return MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          );
        }
        return null;
      },
      home: const AppNavigator(),
    );
  }
}

// Define this once globally
final onboardingStatusProvider = FutureProvider<bool>((ref) async {
  return await OnboardingUtil.isOnboardingCompleted();
});
class AppNavigator extends ConsumerWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(
      authNotifierProvider.select((state) => state.isAuthenticated),
    );

    final onboardingAsync = ref.watch(onboardingStatusProvider);
    if (isAuthenticated) {
      return const MainScreen();
    }
    return onboardingAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => const Scaffold(
        body: Center(child: Text('Error loading onboarding')),
      ),
      data: (onboardingCompleted) {
        if (!onboardingCompleted) {
          return const OnboardingScreen();
        }
        if (isAuthenticated) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}





Future<bool> checkOnboardingStatus() async {
  try {
    final completed = await OnboardingUtil.isOnboardingCompleted();
    return completed;
  } catch (_) {
    // If any error occurs while checking onboarding, treat as not completed
    return false;
  }
}
