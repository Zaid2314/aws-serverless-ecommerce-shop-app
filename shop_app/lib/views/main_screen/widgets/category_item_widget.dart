import 'package:flutter/material.dart';
import 'package:shop_app/controllers/category_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/category_model.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  late Future<List<CategoryModel>> _categoryFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryFuture = CategoryController().fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(future: _categoryFuture, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      if(snapshot.hasError){
        return Center(child: Text('Error ${snapshot.error}'),);
      }
      final categories = snapshot.data ?? [];

      return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      mainAxisSpacing: screenWidth* 0.02,
        crossAxisSpacing: screenWidth *0.02,
            childAspectRatio: 0.8,
      ),
          itemBuilder:(context,index){
          final category = categories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(category.imageUrl, width: MediaQuery.of(context).size.width *0.12,),
              Text(category.categoryName,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth*0.034,
                ),
              )
            ],
          );
          }
      );
    });
  }
}
