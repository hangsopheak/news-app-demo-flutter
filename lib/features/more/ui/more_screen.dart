import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_demo_flutter/features/auth/ui/login_screen.dart';
import 'package:news_app_demo_flutter/features/auth/ui/notifier/auth_notifier.dart';
import 'package:news_app_demo_flutter/l10n/app_localizations.dart';
import 'package:news_app_demo_flutter/shared/providers/app_setting_provider.dart';

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

  Future<void> _onSignOutClick(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sign out')),
        ],
      ),
    );

    if (confirmed == true) {
      // Call the notifier to perform sign out
      await ref.read(authNotifierProvider.notifier).logout();
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
        // Section: Reading Preferences
        PreferenceSectionTitle(AppLocalizations.of(context)!.read_perference),
        ListTile(
          title: Text(AppLocalizations.of(context)!.offline_reading),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onOfflineReadingClick(context),
        ),
        ListTile(
          title:  Text(AppLocalizations.of(context)!.read_articles),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onReadArticlesClick(context),
        ),

        // Section: App Settings
        PreferenceSectionTitle(AppLocalizations.of(context)!.settings),
        ListTile(
          title:  Text(AppLocalizations.of(context)!.notification),
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
              ref.read(languageProvider.notifier).state = const Locale('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Khmer (ភាសាខ្មែរ)'),
            onTap: () {
              ref.read(languageProvider.notifier).state = const Locale('km');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
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