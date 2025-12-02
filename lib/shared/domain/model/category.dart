// This line tells the code generator to create a file named 'category.g.dart'
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

// run command    flutter pub run build_runner build
// or watch    flutter pub run build_runner watch
@JsonSerializable()
class Category {
  final int id;
  final String name;

  // 1. Constructor
  Category({
    required this.id,
    required this.name,
  });

  // Factory method for deserialization - connects to generated code
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  // Method for serialization - connects to generated code
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}