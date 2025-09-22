import 'package:flutter/material.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view/admin_panel/order.dart';
import 'package:tryon/view/product/UploadProductScreen.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _NavigationState();
}

class _NavigationState extends State<AdminNavigation> {
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


        children: [AdminOrdersScreen(), UploadProductScreen(),],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), // Replace with the icon you want
            label: 'Orders', // Add a label if needed
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_sharp,
            ), // Replace with the icon you want
            label: 'Upload', // Add a label if needed
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
