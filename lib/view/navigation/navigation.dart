import 'package:flutter/material.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view/FavoritesScreen.dart';
import 'package:tryon/view/product/FavoritesScreen.dart';
import 'package:tryon/view/ProfileScreen.dart';
import 'package:tryon/view/cart/CartScreen.dart';
import 'package:tryon/view/navigation/home.dart';
import 'package:tryon/view/product/UploadProductScreen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with SingleTickerProviderStateMixin {



  int selectedIndex = 0;
  PageController pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Shop',
      color: AppColors.primaryColor,
    ),
    NavItem(
      icon: Icons.shopping_cart_checkout_outlined,
      activeIcon: Icons.shopping_cart,
      label: 'Cart',
      color: Color(0xFFFF6B00),
    ),
    NavItem(
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      label: 'Favorites',
      color: AppColors.mediumPink,
    ),
    NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      color: AppColors.yellow,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    _animationController.reverse().then((_) {
      setState(() {
        selectedIndex = index;
      });
      pageController.jumpToPage(index);
      _animationController.forward();
    });
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
      bottomNavigationBar: _buildAdvancedNavBar(),
    );
  }

  // Advanced version with FAB and wave effects
  Widget _buildAdvancedNavBar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Background wave effect
        Positioned(
          bottom: 0,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: _NavBarPainter(selectedIndex: selectedIndex),
          ),
        ),
        
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.15),
                blurRadius: 25,
                offset: Offset(0, 8),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // First two items
                ...List.generate(2, (index) => _buildNavItem(_navItems[index], index, selectedIndex == index)),
                
                // Middle FAB-like spacer
                // GestureDetector(
                //   onTap: () {
                //     // Add your FAB action here
                //     print('FAB pressed');
                //   },
                //   child: Container(
                //     width: 60,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       gradient: LinearGradient(
                //         colors: [AppColors.primaryColor, Color(0xFFFF6B00)],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: AppColors.primaryColor.withOpacity(0.4),
                //           blurRadius: 15,
                //           offset: Offset(0, 6),
                //         ),
                //       ],
                //     ),
                //     child: Icon(Icons.add, color: Colors.white, size: 28),
                //   ),
                // ),
                
                // Last two items
                ...List.generate(2, (index) => _buildNavItem(_navItems[index + 2], index + 2, selectedIndex == index + 2)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(NavItem item, int index, bool isActive) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    item.color,
                    Color.lerp(item.color, Colors.orange, 0.3)!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: item.color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isActive ? item.activeIcon : item.icon,
                key: ValueKey(isActive),
                color: isActive ? Colors.white : AppColors.grey.withOpacity(0.7),
                size: isActive ? 24 : 22,
              ),
            ),
            SizedBox(height: 4),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: isActive ? 2 : 0,
              width: isActive ? 20 : 0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            SizedBox(height: 2),
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: isActive ? 1.0 : 0.0,
              child: Text(
                item.label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  final int selectedIndex;

  _NavBarPainter({required this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * (selectedIndex + 0.5) / 4,
      size.height - 15,
      size.width,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;

  NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
  });
}
