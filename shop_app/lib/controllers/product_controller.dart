import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/product_model.dart';

class ProductController{
  Future<List<ProductModel>> fetchProducts() async{
    http.Response response = await http.get(
        Uri.parse(
            'https://fazu87lmqf.execute-api.ap-south-1.amazonaws.com/products'
        ),
    );
    if(response.statusCode==200){
      final List data = json.decode(response.body);
      return data.map((e)=> ProductModel.fromMap(e)).toList();
    }else{
      throw Exception('Failed to load Products');
    }
  }
}