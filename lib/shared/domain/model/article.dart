import 'dart:math';
import 'category.dart';

// import 'category.dart';

class Article {
  final int id;
  final int categoryId;
  final String title;
  final String content;
  final String imageUrl;
  final String? author;
  final DateTime publishedAt;
  final Category category;
  final bool isBreaking;
  final bool isFeatured;
  final bool isLatest;
  final bool isBookMarked;

  // Helper to generate the default DateTime (similar to your Kotlin logic)
  static DateTime _defaultPublishedAt() {
    final randomHours = Random().nextInt(100) + 1; // 1 to 100 hours
    return DateTime.now().subtract(Duration(hours: randomHours));
  }

  // 1. Constructor
  Article({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.author, // Nullable, so it's optional in the constructor
    DateTime? publishedAt,
    required this.category,
    this.isBreaking = false,
    this.isFeatured = false,
    this.isLatest = false,
    this.isBookMarked = false,
  }) : this.publishedAt = publishedAt ?? _defaultPublishedAt(); // Apply the default if not provided

// 2. Factory method for Deserialization (from JSON/Map)
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      author: json['author'] as String?, // Handled as nullable

      // Date conversion: Assumes the JSON contains an ISO 8601 string or similar
      publishedAt: DateTime.parse(json['publishedAt'] as String),

      // Deserialize the nested Category object
      category: Category.fromJson(json['category'] as Map<String, dynamic>),

      isBreaking: json['isBreaking'] as bool? ?? false, // Handle missing field with default
      isFeatured: json['isFeatured'] as bool? ?? false,
      isLatest: json['isLatest'] as bool? ?? false,
      isBookMarked: json['isBookMarked'] as bool? ?? false,
    );
  }

  // 3. Method for Serialization (to JSON/Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'author': author, // Nullable fields can be included directly

      // Date conversion: Convert DateTime to an ISO 8601 string for JSON
      'publishedAt': publishedAt.toIso8601String(),

      // Serialize the nested Category object
      'category': category.toJson(),

      'isBreaking': isBreaking,
      'isFeatured': isFeatured,
      'isLatest': isLatest,
      'isBookMarked': isBookMarked,
    };
  }
}