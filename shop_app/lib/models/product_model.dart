import 'dart:convert';

class ProductModel {
  final String id;
  final String productName;
  final String category;
  final double productPrice;
  final String imageUrl;
  final String description;
  final int quantity;
  final String email;
  final bool isApproved;

  ProductModel({
    required this.id,
    required this.productName,
    required this.category,
    required this.productPrice,
    required this.imageUrl,
    required this.description,
    required this.quantity,
    required this.email,
    required this.isApproved,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'category': category,
      'productPrice': productPrice,
      'imageUrl': imageUrl,
      'description': description,
      'quantity': quantity,
      'email': email,
      'isApproved': isApproved,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      productName: map['productName'] as String,
      category: map['category'] as String,
      productPrice: (map['productPrice'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
      email: map['email'] as String,
      isApproved: map['isApproved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}