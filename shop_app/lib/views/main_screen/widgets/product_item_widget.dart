import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/views/main_screen/details/product_detail_screen.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailScreen(product: product,);
        },
        ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 170,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(product.imageUrl,height:170,
                    width:170,
                    fit:BoxFit.cover,
                  ),
                ),
              ),
      
              const SizedBox(height: 6,),
              Text(product.productName,overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold
                ),
      
              ),
      
              Text(product.category,style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Color(0xff868D94),
                  fontWeight: FontWeight.bold
              ),
              ),
              Text('\$${product.productPrice.toStringAsFixed(2)})',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
