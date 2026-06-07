import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/category_model.dart';

class CategoryController{
  Future<List<CategoryModel>> fetchCategories() async{
    http.Response response = await http.get(Uri.parse('https://5weiunev0i.execute-api.ap-south-1.amazonaws.com/categories'));
    if(response.statusCode==200){
      final List data = json.decode(response.body);
      return data.map((e)=> CategoryModel.fromMap(e)).toList();
    }else{
      throw Exception('Failed to load Categories');
    }
  }
}