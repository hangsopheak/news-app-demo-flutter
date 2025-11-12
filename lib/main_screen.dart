import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/bookmark/bookmark_screen.dart';
import 'package:news_app_demo_flutter/features/explore/ui/explore_screen.dart';
import 'package:news_app_demo_flutter/features/home/ui/home_screen.dart';
import 'package:news_app_demo_flutter/features/more/ui/more_screen.dart';

import 'l10n/app_localizations.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  // List of screens corresponding to the navigation bar items
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    BookmarkScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the current screen based on the selected index
      body:  SafeArea(child: _screens[_currentIndex]),

      // Bottom Navigation Bar implementation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Use fixed type for 4+ items
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: AppLocalizations.of(context)!.explore,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: AppLocalizations.of(context)!.bookmarks,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more_horiz),
            label: AppLocalizations.of(context)!.more,
          ),
        ],
      ),
    );
  }
}

