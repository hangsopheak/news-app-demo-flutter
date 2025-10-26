// Note: This file requires the 'intl' package dependency.
// Add intl: ^0.18.0 (or the latest version) to your pubspec.yaml.

import 'package:intl/intl.dart';

/// A class containing constant string formats for date and time.
class DateFormatConstants {
  static const String ISO_DATE = "yyyy-MM-dd";
  static const String ISO_DATE_TIME = "yyyy-MM-dd'T'HH:mm:ss";
  static const String READABLE = "MMM dd, yyyy";
  static const String READABLE_WITH_TIME = "MMM dd, yyyy 'at' hh:mm a";
  static const String FULL_DATE = "EEEE, MMMM dd, yyyy";
  static const String SHORT_DATE = "MM/dd/yyyy";
  static const String TIME_ONLY = "hh:mm a";
  static const String TIME_24H = "HH:mm";
  static const String MONTH_YEAR = "MMMM yyyy";
  static const String DAY_MONTH =
      "MMM d"; // Changed from 'dd MMM' for closer match to Kotlin's Article Style usage
  static const String ARTICLE_DATE = "MMM d, yyyy";
}

/// Extension methods to add formatting and comparison helpers directly
/// onto Dart's built-in [DateTime] object.
extension DateTimeExtension on DateTime {
  // --- Core Formatting ---

  /// Formats the DateTime object using a given pattern.
  /// Uses the system's default locale if none is provided.
  String format(String pattern, {String? locale}) {
    // Note: If locale is null, DateFormat uses the default locale.
    return DateFormat(pattern, locale).format(this);
  }

  String toReadable({String? locale}) =>
      format(DateFormatConstants.READABLE, locale: locale);
  String toReadableWithTime({String? locale}) =>
      format(DateFormatConstants.READABLE_WITH_TIME, locale: locale);
  String toFullDate({String? locale}) =>
      format(DateFormatConstants.FULL_DATE, locale: locale);
  String toTimeOnly({String? locale}) =>
      format(DateFormatConstants.TIME_ONLY, locale: locale);
  String toShortDate({String? locale}) =>
      format(DateFormatConstants.SHORT_DATE, locale: locale);
  String toArticleDate({String? locale}) =>
      format(DateFormatConstants.ARTICLE_DATE, locale: locale);
  String toDayMonth({String? locale}) =>
      format(DateFormatConstants.DAY_MONTH, locale: locale);

  // --- Comparison Utilities ---

  /// Checks if this DateTime object is on the same day as another DateTime.
  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Checks if this DateTime object is yesterday relative to another DateTime (usually [DateTime.now()]).
  bool isYesterdayAs(DateTime other) {
    final yesterday = other.subtract(const Duration(days: 1));
    return isSameDayAs(yesterday);
  }

  /// Checks if this DateTime object is in the same year as another DateTime.
  bool isSameYearAs(DateTime other) {
    return year == other.year;
  }

  /// Checks if this DateTime object is in the same week as another DateTime.
  bool isSameWeekAs(DateTime other) {
    // Note: Dart's default Weekday starts with Monday=1. This logic is an approximation.
    final startOfWeek = other.subtract(Duration(days: other.weekday - 1)).day;
    final startOfThisWeek = subtract(Duration(days: weekday - 1)).day;
    return isSameYearAs(other) && startOfWeek == startOfThisWeek;
  }

  // --- Relative Time Formatting ---

  /// Formats the date as a relative time string (e.g., "5 hours ago").
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative) {
      return "In the future";
    }

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 2) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else {
      return "${(difference.inDays / 365).floor()} years ago";
    }
  }

  /// Formats the date using smart rules (relative for recent, absolute for older).
  String toSmartFormat({String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(this);
    final days = difference.inDays;

    if (difference.isNegative) {
      return toReadableWithTime(locale: locale);
    }

    if (days == 0) {
      return "Today ${toTimeOnly(locale: locale)}";
    } else if (days == 1) {
      return "Yesterday ${toTimeOnly(locale: locale)}";
    } else if (days < 7) {
      return "$days days ago";
    } else if (days < 365) {
      return toReadable(locale: locale);
    } else {
      return format(DateFormatConstants.MONTH_YEAR, locale: locale);
    }
  }

  // --- Style Formatting ---

  /// Article/Blog style formatting: Today, Yesterday, MMM d, or MMM d, yyyy.
  String toArticleStyle({String? locale}) {
    final now = DateTime.now();

    if (isSameDayAs(now)) {
      return "Today";
    } else if (isYesterdayAs(now)) {
      return "Yesterday";
    } else if (isSameYearAs(now)) {
      return toDayMonth(locale: locale); // "MMM d"
    } else {
      return toArticleDate(locale: locale); // "MMM d, yyyy"
    }
  }

  /// Chat/Message style formatting: hh:mm a, Yesterday, EEEE, MMM d, or MM/dd/yy.
  String toChatStyle({String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (isSameDayAs(now)) {
      return toTimeOnly(locale: locale);
    } else if (isYesterdayAs(now)) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      // Full day name, e.g., 'Friday'
      return format("EEEE", locale: locale);
    } else if (isSameYearAs(now)) {
      return toDayMonth(locale: locale); // "MMM d"
    } else {
      return format("MM/dd/yy", locale: locale);
    }
  }
}

/// A utility class containing static methods for parsing and two-argument
/// date operations.
class DateTimeUtil {
  // --- Parsing ---

  /// Parses a date string using a custom pattern.
  static DateTime? parseDate(String dateString, String pattern,
      {String? locale}) {
    try {
      final formatter = DateFormat(pattern, locale);
      return formatter.parse(dateString);
    } catch (e) {
      // Handle parsing failure gracefully
      return null;
    }
  }

  /// Parses an ISO 8601 string (e.g., "2024-03-15T14:30:00Z").
  static DateTime? parseISOString(String isoString) {
    try {
      // Dart's DateTime.parse() handles ISO 8601 natively.
      return DateTime.parse(isoString);
    } catch (e) {
      return null;
    }
  }

  // --- Duration Formatting ---

  /// Formats the duration between two DateTime objects.
  static String formatDuration(DateTime start, DateTime end) {
    // Use .abs() to handle cases where start > end without affecting calculations
    final duration = end.difference(start).abs();
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    if (days > 0) {
      return "${days}d ${hours}h";
    } else if (hours > 0) {
      return "${hours}h ${minutes}m";
    } else {
      return "${minutes}m";
    }
  }

  /// Gets a readable time difference (e.g., "5 hours").
  static String getTimeDifference(DateTime from, DateTime to) {
    final duration = from.difference(to).abs();
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    if (days > 0) {
      return "$days day${days > 1 ? "s" : ""}";
    } else if (hours > 0) {
      return "$hours hour${hours > 1 ? "s" : ""}";
    } else if (minutes > 0) {
      return "$minutes minute${minutes > 1 ? "s" : ""}";
    } else {
      return "Less than a minute";
    }
  }
}
