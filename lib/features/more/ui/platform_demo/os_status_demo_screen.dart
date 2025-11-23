import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

/// Demo Purpose: Monitor OS status (Network connectivity & Battery level)
/// Uses: connectivity_plus and battery_plus packages
/// Android Permission Required: ACCESS_NETWORK_STATE
class OSStatusDemoScreen extends StatefulWidget {
  const OSStatusDemoScreen({Key? key}) : super(key: key);

  @override
  State<OSStatusDemoScreen> createState() => _OSStatusDemoScreenState();
}

class _OSStatusDemoScreenState extends State<OSStatusDemoScreen> {
  final Connectivity _connectivity = Connectivity();
  final Battery _battery = Battery();

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  int _batteryLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _initializeStatus();
    _setupListeners();
  }

  Future<void> _initializeStatus() async {
    try {
      final result = await _connectivity.checkConnectivity();
      final batteryLevel = await _battery.batteryLevel;
      final batteryState = await _battery.batteryState;

      setState(() {
        _connectionStatus = result;
        _batteryLevel = batteryLevel;
        _batteryState = batteryState;
      });
    } catch (e) {
      debugPrint('Error initializing status: $e');
    }
  }

  void _setupListeners() {
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
          (List<ConnectivityResult> result) {
        setState(() => _connectionStatus = result);
      },
    );

    // Listen to battery state changes
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(
          (BatteryState state) async {
        final level = await _battery.batteryLevel;
        setState(() {
          _batteryState = state;
          _batteryLevel = level;
        });
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _batteryStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OS Status Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNetworkCard(),
            const SizedBox(height: 16),
            _buildBatteryCard()
          ],
        ),
      ),
    );
  }

  // Network status card
  Widget _buildNetworkCard() {
    final isConnected = _connectionStatus.isNotEmpty &&
        _connectionStatus.first != ConnectivityResult.none;
    final statusText = _getConnectionStatusText();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              _getConnectionIcon(),
              size: 64,
              color: isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 12),
            const Text(
              'Network Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              statusText,
              style: TextStyle(
                fontSize: 24,
                color: isConnected ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Battery status card
  Widget _buildBatteryCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              _getBatteryIcon(),
              size: 64,
              color: _getBatteryColor(),
            ),
            const SizedBox(height: 12),
            const Text(
              'Battery Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$_batteryLevel%',
              style: TextStyle(
                fontSize: 32,
                color: _getBatteryColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _getBatteryStateText(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }


  // Helper methods for display
  String _getConnectionStatusText() {
    if (_connectionStatus.isEmpty) return 'Unknown';

    final status = _connectionStatus.first;
    switch (status) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.none:
        return 'No Connection';
      default:
        return 'Unknown';
    }
  }

  IconData _getConnectionIcon() {
    if (_connectionStatus.isEmpty) return Icons.help_outline;

    final status = _connectionStatus.first;
    switch (status) {
      case ConnectivityResult.wifi:
        return Icons.wifi;
      case ConnectivityResult.mobile:
        return Icons.signal_cellular_alt;
      case ConnectivityResult.none:
        return Icons.signal_wifi_off;
      default:
        return Icons.help_outline;
    }
  }

  String _getBatteryStateText() {
    switch (_batteryState) {
      case BatteryState.charging:
        return 'Charging';
      case BatteryState.discharging:
        return 'Discharging';
      case BatteryState.full:
        return 'Full';
      default:
        return 'Unknown';
    }
  }

  IconData _getBatteryIcon() {
    if (_batteryState == BatteryState.charging) {
      return Icons.battery_charging_full;
    }
    if (_batteryLevel > 60) return Icons.battery_full;
    if (_batteryLevel > 30) return Icons.battery_4_bar;
    return Icons.battery_alert;
  }

  Color _getBatteryColor() {
    if (_batteryState == BatteryState.charging) return Colors.green;
    if (_batteryLevel > 20) return Colors.blue;
    return Colors.red;
  }
}