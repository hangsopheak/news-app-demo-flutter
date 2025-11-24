// Counter Notifier
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_notifier.g.dart';

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() {
    return 0; // Initial state
  }

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}