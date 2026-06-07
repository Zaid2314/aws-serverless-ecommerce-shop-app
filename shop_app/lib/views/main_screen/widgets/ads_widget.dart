import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/controllers/banner_controller.dart';
import 'package:shop_app/models/banner_model.dart';

class AdsWidget extends StatefulWidget {
  const AdsWidget({super.key});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  late Future<List<BannerModel>> _bannerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerFuture = BannerController().fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final banners = snapshot.data;
        return CarouselSlider(
          items: banners!.map((banner) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *0.025),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(banner.imageUrl),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height *0.22,
            autoPlay: true,
            viewportFraction: 0.9,

            autoPlayInterval: Duration(seconds: 3),
          ),
        );
      },
    );
  }
}
