import 'package:flutter/material.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view/product/FavoritesScreen.dart';
import 'package:tryon/view/ProfileScreen.dart';
import 'package:tryon/view/cart/CartScreen.dart';
import 'package:tryon/view/navigation/home.dart';
import 'package:tryon/view/product/UploadProductScreen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedindex = 0;

  PageController pageController = PageController();

  void ontap(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),


        children: [Home(), CartScreen(), FavoritesScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), // Replace with the icon you want
            label: 'Shop', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_checkout_outlined,
            ), // Replace with the icon you want
            label: 'Cart', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
            ), // Replace with the icon you want
            label: 'Favourite', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ), // Replace with the icon you want
            label: 'Account', // Add a label if needed
          ),
        ],
        currentIndex: selectedindex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: ontap,
      ),
    );
  }
}
