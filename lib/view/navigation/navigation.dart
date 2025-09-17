import 'package:flutter/material.dart';
import 'package:tryon/constant/app_colors.dart';
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
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),

        // children: [Mein2(), Explore(), Cart(), Account()],
        children: [Home(), CartScreen(), CartScreen(), UploadProductScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Replace with the icon you want
            label: 'Home', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.manage_search_rounded,
            ), // Replace with the icon you want
            label: 'Explore', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ), // Replace with the icon you want
            label: 'Cart', // Add a label if needed
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
