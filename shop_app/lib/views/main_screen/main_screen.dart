import 'package:flutter/material.dart';
import 'package:shop_app/views/main_screen/account_screen.dart';
import 'package:shop_app/views/main_screen/cart_screen.dart';
import 'package:shop_app/views/main_screen/categories_screen.dart';
import 'package:shop_app/views/main_screen/favourite_screen.dart';
import 'package:shop_app/views/main_screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex=0;
  final List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex=value;
          });

        },
          items: [
        BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png',
             width: 25,
            ),
      label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/cart.png',
                  width: 25,
                ),
                label: "CART"
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/love.png',
                  width: 25,
                ),
                label: "FAVOURITE"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.category),
                label:"Categories",
                ),

            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png',
                  width: 25,
                ),
                label: "Account",
            )
      ]
      ),
      body: _pages[_pageIndex],
    );
  }
}
