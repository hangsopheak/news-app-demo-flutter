import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/concept_demo/riverpod/riverpod_home_screen.dart';
import 'package:news_app_demo_flutter/features/auth/notifier/auth_notifier.dart';
import 'package:news_app_demo_flutter/features/auth/ui/login_screen.dart';
import 'package:news_app_demo_flutter/l10n/app_localizations.dart';
import 'package:news_app_demo_flutter/shared/providers/preferences_providers.dart';

import 'platform_demo/camera_demo_screen.dart';
import 'platform_demo/location_demo_screen.dart';
import 'platform_demo/os_status_demo_screen.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  void _onOfflineReadingClick(BuildContext context) {
    debugPrint('Offline Reading clicked');
    // TODO: Navigate to offline reading screen
  }

  void _onReadArticlesClick(BuildContext context) {
    debugPrint('Read Articles clicked');
    // TODO: Navigate to read articles screen
  }

  void _onNotificationsClick(BuildContext context) {
    debugPrint('Notifications clicked');
    // TODO: Navigate to notifications settings
  }

  void _onAppearanceClick(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Light Mode'),
            onTap: () {
              ref.read(themeModeProvider.notifier).setMode(ThemeMode.light);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Dark Mode'),
            onTap: () {
              ref.read(themeModeProvider.notifier).setMode(ThemeMode.dark);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _onLanguageClick(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              ref.read(languageProvider.notifier).setLocale(const Locale('en'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Khmer (ភាសាខ្មែរ)'),
            onTap: () {
              ref.read(languageProvider.notifier).setLocale(const Locale('km'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onAboutUsClick(BuildContext context) {
    debugPrint('About Us clicked');
    // TODO: Navigate to about us screen
  }

  void _onPrivacyClick(BuildContext context) {
    debugPrint('Privacy Policy clicked');
    // TODO: Navigate to privacy policy screen
  }

  void _onTermsClick(BuildContext context) {
    debugPrint('Terms & Conditions clicked');
    // TODO: Navigate to terms screen
  }

  void _onRiverpodDemoClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RiverpodHomeScreen()),
    );
  }

  Future<void> _onSignOutClick(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text(AppLocalizations.of(context)!.signout),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sign out')),
        ],
      ),
    );

    if (confirmed == true) {
      // Call the notifier to perform sign out
      await ref.read(authProvider.notifier).logout();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );

    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [

        // Section: Platform Integration Demos
        PreferenceSectionTitle('Platform Integration Demos'),
        ListTile(
          leading: const Icon(Icons.phone_android),
          title: const Text('OS Status Demo'),
          subtitle: const Text('Battery & Network monitoring'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onOSStatusDemoClick(context),
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera Demo'),
          subtitle: const Text('Camera & Photo access'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onCameraDemoClick(context),
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Location Demo'),
          subtitle: const Text('GPS & Maps integration'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onLocationDemoClick(context),
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications Demo'),
          subtitle: const Text('Local & Push notifications'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onNotificationsDemoClick(context),
        ),

        const Divider(),

        // Section: Reading Preferences
        PreferenceSectionTitle(AppLocalizations.of(context)!.read_perference),
        ListTile(
          title: Text(AppLocalizations.of(context)!.offline_reading),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onOfflineReadingClick(context),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.read_articles),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onReadArticlesClick(context),
        ),

        // --- New Section for Demo Code ---
        const PreferenceSectionTitle('Developer Tools'),
        ListTile(
          leading: const Icon(Icons.psychology_alt, color: Colors.deepOrange), // Eye-catching icon
          title: const Text('Riverpod 3.0 Demo Concepts'),
          subtitle: const Text('State management playground'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onRiverpodDemoClick(context), // Navigate to the demo screen
        ),

        // Section: App Settings
        PreferenceSectionTitle(AppLocalizations.of(context)!.settings),
        ListTile(
          title: Text(AppLocalizations.of(context)!.notification),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onNotificationsClick(context),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.appearance),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onAppearanceClick(context, ref),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.language),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onLanguageClick(context, ref),
        ),

        // Section: About
        PreferenceSectionTitle(AppLocalizations.of(context)!.about),
        ListTile(
          title: Text(AppLocalizations.of(context)!.about_us),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onAboutUsClick(context),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.privacy_policy),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onPrivacyClick(context),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.terms),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onTermsClick(context),
        ),

        // Sign out
        ListTile(
          title: Text(AppLocalizations.of(context)!.signout),
          trailing: const Icon(Icons.logout),
          onTap: () => _onSignOutClick(context, ref),
        ),


        // App Version
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  void _onOSStatusDemoClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OSStatusDemoScreen()),
    );
  }

  void _onCameraDemoClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraDemoScreen()),
    );
  }

  void _onLocationDemoClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationDemoScreen()),
    );
  }

  void _onNotificationsDemoClick(BuildContext context) {}

}

class PreferenceSectionTitle extends StatelessWidget {
  final String title;

  const PreferenceSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}