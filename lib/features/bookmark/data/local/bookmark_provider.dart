// bookmark_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bookmark_service.dart';

// We throw an error by default to force ourselves to override it in main.dart
final bookmarkServiceProvider = Provider<BookmarkService>((ref) {
  throw UnimplementedError('Initialize Hive in main.dart first');
});