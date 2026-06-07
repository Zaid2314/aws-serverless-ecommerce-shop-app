import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail',style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Product Image
            Center(
              child: Image.network(
                widget.product.imageUrl,
              width: 260,
              height: 275,
              fit: BoxFit.cover,
              )
            ),

            SizedBox(height: 12,),

              //Product name and Price
            Padding(padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: GoogleFonts.poppins(
                  fontSize: 17,
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C55EF),
                ),
                ),
                Text(
                  '\$${widget.product.productPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C55EF),
                  ),
                ),
              ],
            ),
            ),

            SizedBox(height: 8,),
            // Category
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(widget.product.category,
              style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
              ),
            ),

            SizedBox(height: 12,),

            //Description
            Padding(padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About', style: GoogleFonts.poppins(
                  fontSize: 17,
                  letterSpacing: 1.7,
                  color: Color(0xFF363330),
                ),
                ),
                SizedBox(height: 4,),
                Text(widget.product.description,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  letterSpacing: 1.7
                ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: EdgeInsets.all(8),
          child:Container(
            width: 386,
            height: 46,
            decoration: BoxDecoration(
            color: Color(0xFF3b54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text('ADD TO CART', style: GoogleFonts.mochiyPopOne(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),),
          ),
      ),
    );
  }
}
