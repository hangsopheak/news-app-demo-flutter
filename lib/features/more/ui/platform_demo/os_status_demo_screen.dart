import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

class OSStatusDemoScreen extends StatefulWidget {
  const OSStatusDemoScreen({super.key});

  @override
  State<OSStatusDemoScreen> createState() => _OSStatusDemoScreenState();
}

class _OSStatusDemoScreenState extends State<OSStatusDemoScreen> {
  final Battery _battery = Battery();
  int _batteryLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;
  late StreamSubscription<BatteryState> _batterySub;

  @override
  void initState() {
    super.initState();
    _initBattery();
    // Listen to battery changes
    _batterySub = _battery.onBatteryStateChanged.listen((state) async {
      final level = await _battery.batteryLevel;
      if (mounted) {
        setState(() {
          _batteryState = state;
          _batteryLevel = level;
        });
      }
    });
  }

  Future<void> _initBattery() async {
    final level = await _battery.batteryLevel;
    final state = await _battery.batteryState;
    if (mounted) {
      setState(() {
        _batteryState = state;
        _batteryLevel = level;
      });
    }
  }

  @override
  void dispose() {
    _batterySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OS Status Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Connectivity Card using StreamBuilder (Reactive)
            StreamBuilder<List<ConnectivityResult>>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                final results = snapshot.data ?? [ConnectivityResult.none];
                final isConnected = !results.contains(ConnectivityResult.none);

                return _StatusCard(
                  title: 'Network Status',
                  value: isConnected ? (results.contains(ConnectivityResult.wifi) ? 'WiFi' : 'Mobile') : 'Offline',
                  icon: isConnected ? Icons.wifi : Icons.wifi_off,
                  color: isConnected ? Colors.green : Colors.red,
                );
              },
            ),
            const SizedBox(height: 16),
            // 2. Battery Card using local state
            _StatusCard(
              title: 'Battery Status',
              value: '$_batteryLevel% (${_batteryState.name})',
              icon: _batteryState == BatteryState.charging ? Icons.battery_charging_full : Icons.battery_std,
              color: _batteryState == BatteryState.charging || _batteryLevel > 20 ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget to reduce duplication
class _StatusCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const _StatusCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
                  Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}