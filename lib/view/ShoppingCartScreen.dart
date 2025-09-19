// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui';

// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/constant/app_images.dart';

// class ShoppingCartScreen extends StatefulWidget {
//   const ShoppingCartScreen({Key? key}) : super(key: key);

//   @override
//   State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
// }

// class _ShoppingCartScreenState extends State<ShoppingCartScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _cartAnimationController;
//   late AnimationController _priceAnimationController;
//   late AnimationController _fadeAnimationController;
//   late Animation<double> _cartAnimation;
//   late Animation<double> _priceAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _cartAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _priceAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _fadeAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _cartAnimation = CurvedAnimation(
//       parent: _cartAnimationController,
//       curve: Curves.elasticOut,
//     );

//     _priceAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _priceAnimationController,
//       curve: Curves.easeOutBack,
//     ));

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     _cartAnimationController.forward();
//     _fadeAnimationController.forward();
//     _priceAnimationController.forward();
//   }

//   @override
//   void dispose() {
//     _cartAnimationController.dispose();
//     _priceAnimationController.dispose();
//     _fadeAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient,
//         ),
//         child: SafeArea(
//           child: CustomScrollView(
//             slivers: [
//               _buildHeader(),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Column(
//                       children: [
//                         ..._buildCartItems(),
//                         const SizedBox(height: 32),
//                         _buildTotalSection(),
//                         const SizedBox(height: 24),
//                         _buildCheckoutButton(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return SliverAppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: AnimatedBuilder(
//         animation: _cartAnimation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _cartAnimation.value,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'My Cart',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.grey,
//                     height: 1.2,
//                   ),
//                 ),
//                 Text(
//                   '4 items • PKR 9,780',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1),
//         child: Container(
//           height: 1,
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             gradient: LinearGradient(
//               colors: [AppColors.primaryColor.withOpacity(0.3), Colors.transparent],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildCartItems() {
//     final items = [
//       {
//         'image': 'assets/denim.png',
//         'name': 'Grey Tee',
//         'color': 'Cotton Fabric',
//         'price': 2093.0,
//         'colorScheme': Colors.grey[300],
//       },
//       {
//         'image': 'assets/denim.png',
//         'name': 'Slim Fit Tee',
//         'color': 'Cotton Fabric',
//         'price': 2093.0,
//         'colorScheme': Colors.brown[100],
//       },
//       {
//         'image': 'assets/denim.png',
//         'name': 'Maroon Tee',
//         'color': 'Cotton Fabric',
//         'price': 2093.0,
//         'colorScheme': Colors.red[100],
//       },
//       {
//         'image': 'assets/denim.png',
//         'name': "Men's Slim Fit Jeans",
//         'color': 'Denim Blue',
//         'price': 2690.0,
//         'colorScheme': Colors.blue[100],
//       },
//     ];

//     return items.map((item) {
//       return _buildCartItem(
//         image: "assets/denim.png",
//         name: "abbkfl sksjlkj",
//         color:"Black",
//         price: 2000,
//         colorScheme: Colors.blue[100]??Colors.blue,
//       );
//     }).toList();
//   }

//   Widget _buildCartItem({
//     required String image,
//     required String name,
//     required String color,
//     required double price,
//     required Color colorScheme,
//   }) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 600),
//       builder: (context, double value, child) {
//         return Transform.translate(
//           offset: Offset(50 * (1 - value), 0),
//           child: Opacity(
//             opacity: value,
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Product Image Container
//                   Container(
//                     width: 100,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         bottomLeft: Radius.circular(20),
//                       ),
//                       color: colorScheme.withOpacity(0.2),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         bottomLeft: Radius.circular(20),
//                       ),
//                       child: Stack(
//                         children: [
//                           // Placeholder image - replace with your actual image
//                           Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   colorScheme,
//                                   colorScheme.withOpacity(0.5),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.image,
//                               size: 40,
//                               color: Colors.white,
//                             ),
//                           ),
//                           // Price badge
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 'PKR ${price.toInt()}',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   // Product Details
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             name,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             color,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
                          
//                           // Quantity Selector
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _buildQuantityButton('-', () => _updateQuantity(false)),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 12,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: colorScheme.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: colorScheme.withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   '1',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.grey,
//                                   ),
//                                 ),
//                               ),
//                               _buildQuantityButton('+', () => _updateQuantity(true)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   // Remove Button
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () => _removeItem(),
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.close,
//                           color: Colors.red,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildQuantityButton(String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalSection() {
//     return AnimatedBuilder(
//       animation: _priceAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _priceAnimation.value,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   blurRadius: 20,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Subtotal',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       'PKR 9,780',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Tax (5%)',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       'PKR 489',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       'PKR 10,269',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCheckoutButton() {
//     return AnimatedBuilder(
//       animation: _cartAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: 1.0 + (_cartAnimation.value * 0.05),
//           child: GestureDetector(
//             onTap: _goToCheckout,
//             child: Container(
//               width: double.infinity,
//               height: 60,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor,
//                     AppColors.primaryColor.withOpacity(0.8),
//                   ],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.3),
//                     blurRadius: 15,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: const Center(
//                 child: Text(
//                   'Go to Checkout',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _updateQuantity(bool increase) {
//     // Implement quantity update logic
//     setState(() {});
//     // Add haptic feedback
//     HapticFeedback.lightImpact();
//   }

//   void _removeItem() {
//     // Implement remove item logic
//     setState(() {});
//     HapticFeedback.mediumImpact();
//   }

//   void _goToCheckout() {
//     // Implement checkout logic
//     HapticFeedback.heavyImpact();
//     Navigator.pushNamed(context, '/checkout');
//   }
// }

// // Usage in your main app
// class CartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Shopping Cart Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         fontFamily: 'Inter',
//       ),
//       home: const ShoppingCartScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/model/CartItem.dart';
import 'package:tryon/view/product/OrderConfirmationScreen.dart';
import 'package:tryon/view_model/CartController.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen>
    with TickerProviderStateMixin {
  late AnimationController _cartAnimationController;
  late AnimationController _priceAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _cartAnimation;
  late Animation<double> _priceAnimation;
  late Animation<double> _fadeAnimation;

  // GetX Controller
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    _cartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _priceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cartAnimation = CurvedAnimation(
      parent: _cartAnimationController,
      curve: Curves.elasticOut,
    );

    _priceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _priceAnimationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeInOut,
    ));

    _cartAnimationController.forward();
    _fadeAnimationController.forward();
    _priceAnimationController.forward();
  }

  @override
  void dispose() {
    _cartAnimationController.dispose();
    _priceAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        // Dynamic cart items from controller
                        Obx(() => _buildCartItems()),
                        const SizedBox(height: 32),
                        _buildTotalSection(),
                        const SizedBox(height: 24),
                        _buildCheckoutButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Obx(() {
        final itemCount = cartController.cartItems.length;
        final total = cartController.totalPrice;
        return AnimatedBuilder(
          animation: _cartAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _cartAnimation.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    '${itemCount} items • PKR ${total.toInt()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [AppColors.primaryColor.withOpacity(0.3), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    final items = cartController.cartItems;
    
    if (items.isEmpty) {
      return _buildEmptyCart();
    }

    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _buildCartItem(
          item: item,
          animationDelay: index * 100,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Icon(
          Icons.shopping_cart_outlined,
          size: 80,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'Your cart is empty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add some items to get started!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.store),
          label: const Text('Continue Shopping'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem({
    required CartItem item,
    required int animationDelay,
  }) {
    // Generate a color scheme based on item index or use a default
    Color colorScheme = _getColorSchemeForItem(item);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + animationDelay),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Product Image Container
                  Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: colorScheme.withOpacity(0.2),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          if (item.image.isNotEmpty)

CachedNetworkImage(
  imageUrl: item.image,
  fit: BoxFit.cover,
  width: double.infinity,
  height: double.infinity,
  placeholder: (context, url) => Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
    ),
  ),
  errorWidget: (context, url, error) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme,
            colorScheme.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.image,
        size: 40,
        color: Colors.white,
      ),
    );
  },
)

                          else
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme,
                                    colorScheme.withOpacity(0.5),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          // Price badge
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'PKR ${item.price.toInt()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Product Details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.color.isNotEmpty ? item.color : 'Standard Fabric',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Quantity Selector
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildQuantityButton(
                                '-',
                                () => cartController.removeFromCart(item),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: colorScheme.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                              _buildQuantityButton(
                                '+',
                                () => cartController.addToCart(item.name, item.price, item.image),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Remove Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _showRemoveConfirmation(item),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getColorSchemeForItem(CartItem item) {
    // You can customize this logic based on your needs
    final colors = [
      Colors.grey[300]!,
      Colors.brown[100]!,
      Colors.red[100]!,
      Colors.blue[100]!,
      Colors.green[100]!,
      Colors.purple[100]!,
      Colors.orange[100]!,
    ];
    
    // Simple hash-based color assignment
    final index = item.name.hashCode % colors.length;
    return colors[index.abs()];
  }

  Widget _buildQuantityButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showRemoveConfirmation(CartItem item) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700], size: 28),
            const SizedBox(width: 12),
            const Text('Remove Item'),
          ],
        ),
        content: Text('Are you sure you want to remove "${item.name}" from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              cartController.removeFromCart(item);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildTotalSection() {
    return Obx(() {
      final total = cartController.totalPrice;
      final tax = total * 0.05;
      final grandTotal = total + tax;
      
      return AnimatedBuilder(
        animation: _priceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _priceAnimation.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'PKR ${total.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax (5%)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'PKR ${tax.toInt()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'PKR ${grandTotal.toInt()}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildCheckoutButton() {
    return Obx(() {
      final hasItems = cartController.cartItems.isNotEmpty;
      
      return AnimatedBuilder(
        animation: _cartAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_cartAnimation.value * 0.05),
            child: GestureDetector(
              onTap: hasItems ? _goToCheckout : null,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasItems
                        ? [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ]
                        : [
                            Colors.grey,
                            Colors.grey.withOpacity(0.6),
                          ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: hasItems
                          ? AppColors.primaryColor.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    hasItems ? 'Go to Checkout' : 'Add Items to Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void _goToCheckout() {
    if (cartController.cartItems.isNotEmpty) {
      HapticFeedback.heavyImpact();
     Navigator.push(context, MaterialPageRoute(builder: (context){
return OrderConfirmationScreen();
     }));
     
    }
  }
}