import 'dart:convert';

class CategoryModel {
  final String categoryName;
  final String imageUrl;

  CategoryModel({
    required this.categoryName,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}