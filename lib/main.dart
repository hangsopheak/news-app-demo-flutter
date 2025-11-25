import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/auth/notifier/auth_notifier.dart';
import 'package:news_app_demo_flutter/routes/app_routes.dart';
import 'package:news_app_demo_flutter/shared/providers/preferences_providers.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- Imports (Adjust paths as needed) ---
import 'features/article/ui/article_detail_screen.dart';
import 'features/auth/ui/login_screen.dart';
import 'features/onboarding/ui/onboarding_screen.dart';
import 'features/onboarding/utils/onboarding_util.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'main_screen.dart';
import 'shared/domain/model/article.dart';
// ----------------------------------------

/*
Configure Firebase
# Install firebase-tools
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# login
firebase login

# Configure Firebase (auto-setup)
flutterfire configure --project=news-flutter-app-f2a2a
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences = await SharedPreferences.getInstance();


  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(languageProvider), // reactive with Riverpod
      themeMode: ref.watch(themeModeProvider),
      // --- Theming ---
      theme: NewsAppTheme.lightTheme,
      darkTheme: NewsAppTheme.darkTheme,

      // --- Route Generation ---
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.articleDetail) {
          final article = settings.arguments as Article;
          return MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          );
        }
        return null; // Let Flutter handle other routes (or 404)
      },

      // --- Entry Point (Auth & Onboarding Logic) ---
      home: const AuthGate(),
    );
  }
}

/// The Gatekeeper Widget
/// This component decides which screen to show based on:
/// 1. Authentication Status (from Riverpod)
/// 2. Onboarding Status (from SharedPreferences/Util)
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the global Auth State
    final authState = ref.watch(authProvider);

    return authState.when(
      // A. Loading: Show a clean splash or loader while Firebase checks session
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),

      // B. Error: Critical Auth Failure
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Authentication Error: $err')),
      ),

      // C. Data: We have a User (or null)
      data: (user) {
        // Case 1: User is Logged In -> Go straight to the App
        if (user != null) {
          return const MainScreen();
        }

        // Case 2: User is Logged Out -> Check Onboarding Status
        // We use FutureBuilder because SharedPreferences is asynchronous
        return FutureBuilder<bool>(
          future: OnboardingUtil.isOnboardingCompleted(),
          builder: (context, snapshot) {

            // While checking SharedPreferences...
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final isOnboardingCompleted = snapshot.data ?? false;

            // Decision Logic:
            if (isOnboardingCompleted) {
              // User has seen onboarding before -> Show Login
              return const LoginScreen();
            } else {
              // First time user -> Show Onboarding
              return const OnboardingScreen();
            }
          },
        );
      },
    );
  }
}