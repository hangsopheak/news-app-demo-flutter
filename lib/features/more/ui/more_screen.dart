import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
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

  void _onAppearanceClick(BuildContext context) {
    debugPrint('Appearance clicked');
    // TODO: Navigate to appearance settings
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Section: Reading Preferences
        const PreferenceSectionTitle('Reading Preferences'),
        ListTile(
          title: const Text('Offline Reading'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onOfflineReadingClick(context),
        ),
        ListTile(
          title: const Text('Read Articles'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onReadArticlesClick(context),
        ),

        // Section: App Settings
        const PreferenceSectionTitle('App Settings'),
        ListTile(
          title: const Text('Notifications'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onNotificationsClick(context),
        ),
        ListTile(
          title: const Text('Appearance'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onAppearanceClick(context),
        ),

        // Section: About
        const PreferenceSectionTitle('About'),
        ListTile(
          title: const Text('About Us'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onAboutUsClick(context),
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onPrivacyClick(context),
        ),
        ListTile(
          title: const Text('Terms & Conditions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _onTermsClick(context),
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