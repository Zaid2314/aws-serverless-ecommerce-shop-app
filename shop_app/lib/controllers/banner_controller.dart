import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/banner_model.dart';

class BannerController {
  Future<List<BannerModel>> fetchBanners() async {
    final response = await http.get(
      Uri.parse('https://r8pj8vyx4e.execute-api.ap-south-1.amazonaws.com/ads'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List data = json.decode(response.body);

      return data.map((e) => BannerModel.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load banners');
    }
  }
}