import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsDemoScreen extends StatefulWidget {
  const NotificationsDemoScreen({super.key});

  @override
  State<NotificationsDemoScreen> createState() => _NotificationsDemoScreenState();
}

class _NotificationsDemoScreenState extends State<NotificationsDemoScreen> {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  String _statusMessage = 'Ready to send notifications';
  int _idCounter = 0;

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings),
      onDidReceiveNotificationResponse: (response) {
        if (mounted) setState(() => _statusMessage = 'Tapped payload: ${response.payload}');
      },
    );

    // Request permissions for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Helper method to create notification details (Reduces boilerplate)
  NotificationDetails _getDetails({
    required String channelId,
    required String channelName,
    String? description,
    StyleInformation? style,
    List<AndroidNotificationAction>? actions,
    bool showProgress = false,
    int progress = 0,
    int maxProgress = 0,
    bool ongoing = false,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: description,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: style,
        actions: actions,
        showProgress: showProgress,
        progress: progress,
        maxProgress: maxProgress,
        ongoing: ongoing,
        onlyAlertOnce: showProgress, // Prevents sound spam during progress updates
      ),
    );
  }

  Future<void> _showSimple() async {
    await _notificationsPlugin.show(
      _idCounter++,
      'Simple Notification',
      'This is a basic notification',
      _getDetails(channelId: 'simple', channelName: 'Simple'),
      payload: 'simple_payload',
    );
    setState(() => _statusMessage = 'Simple notification sent');
  }

  Future<void> _showBigText() async {
    final style = BigTextStyleInformation(
      'This is a very long message that expands when you pull down on the notification. '
          'It allows you to display much more content than a standard notification.',
      contentTitle: 'Expanded Big Text Title',
      summaryText: 'Tap to see more',
    );

    await _notificationsPlugin.show(
      _idCounter++,
      'Big Text Notification',
      'Pull down to expand...',
      _getDetails(channelId: 'big_text', channelName: 'Big Text', style: style),
    );
    setState(() => _statusMessage = 'Big text notification sent');
  }

  Future<void> _showWithActions() async {
    await _notificationsPlugin.show(
      _idCounter++,
      'Action Required',
      'Please choose an option',
      _getDetails(
        channelId: 'actions',
        channelName: 'Actions',
        actions: [
          const AndroidNotificationAction('accept', 'Accept', showsUserInterface: true),
          const AndroidNotificationAction('decline', 'Decline', showsUserInterface: true),
        ],
      ),
      payload: 'action_notification',
    );
    setState(() => _statusMessage = 'Action notification sent');
  }

  Future<void> _showProgress() async {
    const int max = 100;
    const int id = 999; // Fixed ID to update the same notification

    setState(() => _statusMessage = 'Starting download...');

    for (int i = 0; i <= max; i += 10) {
      if (!mounted) return; // Safety check
      await Future.delayed(const Duration(milliseconds: 500));

      await _notificationsPlugin.show(
        id,
        'Downloading...',
        '$i% complete',
        _getDetails(
          channelId: 'progress',
          channelName: 'Progress',
          showProgress: true,
          maxProgress: max,
          progress: i,
          ongoing: i < max,
        ),
      );
    }

    if (mounted) setState(() => _statusMessage = 'Progress notification complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await _notificationsPlugin.cancelAll();
              if (mounted) setState(() => _statusMessage = 'All notifications cancelled');
            },
            tooltip: 'Cancel All',
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStatusCard(),
          const SizedBox(height: 16),
          _buildButton('Simple Notification', 'Basic title and body', Icons.notifications, _showSimple),
          _buildButton('Big Text', 'Expandable long text', Icons.subject, _showBigText),
          _buildButton('Action Notification', 'With action buttons', Icons.touch_app, _showWithActions),
          _buildButton('Progress Bar', 'Simulates a download', Icons.download, _showProgress),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.notifications_active, size: 48, color: Colors.blue),
            const SizedBox(height: 12),
            Text(_statusMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        leading: Icon(icon, color: Colors.blue, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}