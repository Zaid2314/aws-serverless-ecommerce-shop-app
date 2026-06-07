import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/views/main_screen/widgets/product_item_widget.dart';

import '../../../controllers/product_controller.dart';

class AllProductWidget extends StatefulWidget {
  const AllProductWidget({super.key});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  late Future<List<ProductModel>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductController().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final products = snapshot.data!;

        return SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductItemWidget(
                product: product,
              );
            },
          ),
        );
      },
    );
  }
}