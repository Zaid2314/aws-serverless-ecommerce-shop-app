import 'package:flutter/material.dart';
import 'package:shop_app/views/main_screen/widgets/ads_widget.dart';
import 'package:shop_app/views/main_screen/widgets/all_product_widget.dart';
import 'package:shop_app/views/main_screen/widgets/category_item_widget.dart';
import 'package:shop_app/views/main_screen/widgets/header_widget.dart';
import 'package:shop_app/views/main_screen/widgets/reusable_text_widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        HeaderWidget(),
        AdsWidget(),
        ReusableTextWidget(title: 'Categories', subtitle: 'View All'),
        CategoryItemWidget(),
        SizedBox(height: 20,),
        ReusableTextWidget(
          title: 'Popular Products',
          subtitle: 'View All',
        ),

        AllProductWidget(),
      ],)
    );
  }
}

