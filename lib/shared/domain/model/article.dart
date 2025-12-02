import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';


part 'article.g.dart';
// -----------------------------------------------------------------------------
// DEVELOPMENT NOTES
//
// To enable JSON serialization (@JsonSerializable), ensure your dependencies are set up:
//   1. Add annotations:       flutter pub add json_annotation
//   2. Add generator (dev):   flutter pub add --dev json_serializable
//   3. Add build runner (dev): flutter pub add --dev build_runner
//
// To generate the code (.g.dart files), run:
//   flutter pub run build_runner build --delete-conflicting-outputs
// -----------------------------------------------------------------------------
@JsonSerializable()
class Article {
  final int id;
  final int categoryId;
  final String title;
  final String content;
  final String imageUrl;
  @JsonKey(name: 'authors')
  final String? author;
  final DateTime publishedAt;
  final Category category;
  @JsonKey(defaultValue: false)
  final bool isBreaking;
  @JsonKey(defaultValue: false)
  final bool isFeatured;
  @JsonKey(defaultValue: false)
  final bool isLatest;
  @JsonKey(name: 'isBookmarked', defaultValue: false)
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
  }) : this.publishedAt = publishedAt ?? _defaultPublishedAt();

  // Factory method for deserialization - connects to generated code
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  // Method for serialization - connects to generated code
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  // 4. copyWith method
  Article copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? content,
    String? imageUrl,
    String? author,
    DateTime? publishedAt,
    Category? category,
    bool? isBreaking,
    bool? isFeatured,
    bool? isLatest,
    bool? isBookMarked,
  }) {
    return Article(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      category: category ?? this.category,
      isBreaking: isBreaking ?? this.isBreaking,
      isFeatured: isFeatured ?? this.isFeatured,
      isLatest: isLatest ?? this.isLatest,
      isBookMarked: isBookMarked ?? this.isBookMarked,
    );
  }

}