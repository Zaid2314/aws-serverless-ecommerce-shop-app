// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BannerModel {
  final String imageUrl;

  BannerModel({required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) => BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
