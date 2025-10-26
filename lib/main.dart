import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

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
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("TEST THEME"),
              )),
        ),
      ),
    );
  }
}
