import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class LocationDemoScreen extends StatefulWidget {
  const LocationDemoScreen({super.key});

  @override
  State<LocationDemoScreen> createState() => _LocationDemoScreenState();
}

class _LocationDemoScreenState extends State<LocationDemoScreen> {
  Position? _currentPosition;
  String _statusMessage = 'Press button to get location';
  bool _isLoading = false;

  Future<bool> _checkPermissions() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _updateStatus('Location services are disabled.');
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _updateStatus('Location permissions are denied.');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _updateStatus('Location permissions are permanently denied.');
        return false;
      }
      return true;
    } on MissingPluginException {
      _updateStatus('Error: Plugin not loaded. Please restart app.');
      return false;
    } catch (e) {
      _updateStatus('Permission Error: $e');
      return false;
    }
  }

  void _updateStatus(String message) {
    if (mounted) setState(() => _statusMessage = message);
  }

  Future<void> _getCurrentLocation() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    _updateStatus('Getting location...');

    try {
      if (await _checkPermissions()) {
        final position = await Geolocator.getCurrentPosition();
        if (mounted) {
          setState(() {
            _currentPosition = position;
            _statusMessage = 'Location retrieved successfully';
          });
        }
      }
    } catch (e) {
      _updateStatus('Error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusCard(),
              const SizedBox(height: 16),
              if (_currentPosition != null) ...[
                _buildLocationDetails(),
                const SizedBox(height: 16),
              ],
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              _currentPosition != null ? Icons.location_on : Icons.location_off,
              size: 48,
              color: _currentPosition != null ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(_statusMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            if (_isLoading) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _row('Latitude', _currentPosition!.latitude.toStringAsFixed(6)),
            const Divider(),
            _row('Longitude', _currentPosition!.longitude.toStringAsFixed(6)),
            const Divider(),
            _row('Accuracy', '${_currentPosition!.accuracy.toStringAsFixed(1)} m'),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _isLoading ? null : _getCurrentLocation,
        icon: const Icon(Icons.pin_drop),
        label: const Text('Get Current Location'),
      ),
    );
  }
}