// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: (json['id'] as num).toInt(),
  categoryId: (json['categoryId'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String,
  author: json['authors'] as String?,
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  isBreaking: json['isBreaking'] as bool? ?? false,
  isFeatured: json['isFeatured'] as bool? ?? false,
  isLatest: json['isLatest'] as bool? ?? false,
  isBookMarked: json['isBookmarked'] as bool? ?? false,
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'id': instance.id,
  'categoryId': instance.categoryId,
  'title': instance.title,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'authors': instance.author,
  'publishedAt': instance.publishedAt.toIso8601String(),
  'category': instance.category,
  'isBreaking': instance.isBreaking,
  'isFeatured': instance.isFeatured,
  'isLatest': instance.isLatest,
  'isBookmarked': instance.isBookMarked,
};
