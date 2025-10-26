class Category {
  final int id;
  final String name;

  // 1. Constructor
  Category({
    required this.id,
    required this.name,
  });

  // 2. Factory method for deserialization (from a Map/JSON)
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  // 3. Method for serialization (to a Map/JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

}