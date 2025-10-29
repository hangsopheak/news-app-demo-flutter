import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/onboarding/ui/onboarding_screen.dart';
import 'package:news_app_demo_flutter/features/onboarding/utils/onboarding_util.dart';
import 'package:news_app_demo_flutter/main_screen.dart';
import 'package:news_app_demo_flutter/routes/app_routes.dart';
import 'package:news_app_demo_flutter/shared/domain/model/article.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

import 'features/article/ui/article_detail_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      themeMode: ThemeMode.system,
      theme: NewsAppTheme.lightTheme,
      darkTheme: NewsAppTheme.darkTheme,
      onGenerateRoute: (settings){
        if (settings.name == AppRoutes.articleDetail) {
          final article = settings.arguments as Article;
          return MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          );
        }
        return null; // Let Flutter handle other routes normally

      },
      home: FutureBuilder<bool>(
        future: OnboardingUtil.isOnboardingCompleted(),
        builder: (context, snapshot) {
          // Show loading screen while checking
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Handle error state
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Error loading app'),
              ),
            );
          }

          // Navigate based on onboarding status
          final isCompleted = snapshot.data ?? false;
          return isCompleted ? const MainScreen() : const OnboardingScreen();
        },
      ),
    );
  }
}
