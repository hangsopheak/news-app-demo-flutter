import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/shared/constants/app_colors.dart';
import 'package:news_app_demo_flutter/shared/theme/custom_theme/appbar_theme.dart';
import 'package:news_app_demo_flutter/shared/theme/custom_theme/chip_theme.dart';
import 'package:news_app_demo_flutter/shared/theme/custom_theme/elevated_button_theme.dart';
import 'package:news_app_demo_flutter/shared/theme/custom_theme/text_theme.dart';

class NewsAppTheme {
  NewsAppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white, // Background for surfaces
      surfaceContainerLowest: Colors.white, // Card backgrounds
      surfaceContainerLow: Colors.white, // Container backgrounds
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primary,
    textTheme: MyTextTheme.lightTextTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.black, // Background for surfaces
      surfaceContainerLowest: Colors.black, // Card backgrounds
      surfaceContainerLow: Colors.black, // Container backgrounds
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: AppColors.primary,
    textTheme: MyTextTheme.darkTextTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
