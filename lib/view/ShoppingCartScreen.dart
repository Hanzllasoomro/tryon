



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'dart:ui';

// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/model/CartItem.dart';
// import 'package:tryon/view/product/OrderConfirmationScreen.dart';
// import 'package:tryon/view_model/CartController.dart';

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

//   // GetX Controller
//   final CartController cartController = Get.find<CartController>();

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
//                         // Dynamic cart items from controller
//                         Obx(() => _buildCartItems()),
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
//       title: Obx(() {
//         final itemCount = cartController.cartItems.length;
//         final total = cartController.totalPrice;
//         return AnimatedBuilder(
//           animation: _cartAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _cartAnimation.value,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'My Cart',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.grey,
//                       height: 1.2,
//                     ),
//                   ),
//                   Text(
//                     '${itemCount} items • PKR ${total.toInt()}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
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

//   Widget _buildCartItems() {
//     final items = cartController.cartItems;
    
//     if (items.isEmpty) {
//       return _buildEmptyCart();
//     }

//     return Column(
//       children: items.asMap().entries.map((entry) {
//         final index = entry.key;
//         final item = entry.value;
//         return _buildCartItem(
//           item: item,
//           animationDelay: index * 100,
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildEmptyCart() {
//     return Column(
//       children: [
//         SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//         Icon(
//           Icons.shopping_cart_outlined,
//           size: 80,
//           color: Colors.grey[400],
//         ),
//         const SizedBox(height: 16),
//         Text(
//           'Your cart is empty',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: AppColors.grey,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Add some items to get started!',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//           ),
//         ),
//         const SizedBox(height: 32),
//         ElevatedButton.icon(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.store),
//           label: const Text('Continue Shopping'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primaryColor,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCartItem({
//     required CartItem item,
//     required int animationDelay,
//   }) {
//     // Generate a color scheme based on item index or use a default
//     Color colorScheme = _getColorSchemeForItem(item);

//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: 600 + animationDelay),
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
//                           if (item.image.isNotEmpty)

// CachedNetworkImage(
//   imageUrl: item.image,
//   fit: BoxFit.cover,
//   width: double.infinity,
//   height: double.infinity,
//   placeholder: (context, url) => Center(
//     child: CircularProgressIndicator(
//       strokeWidth: 2,
//     ),
//   ),
//   errorWidget: (context, url, error) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colorScheme,
//             colorScheme.withOpacity(0.5),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: const Icon(
//         Icons.image,
//         size: 40,
//         color: Colors.white,
//       ),
//     );
//   },
// )

//                           else
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     colorScheme,
//                                     colorScheme.withOpacity(0.5),
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                               ),
//                               child: const Icon(
//                                 Icons.image,
//                                 size: 40,
//                                 color: Colors.white,
//                               ),
//                             ),
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
//                                 'PKR ${item.price.toInt()}',
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
//                             item.name,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.grey,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             item.color.isNotEmpty ? item.color : 'Standard Fabric',
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
//                               _buildQuantityButton(
//                                 '-',
//                                 () => cartController.removeFromCart(item),
//                               ),
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
//                                   '${item.quantity}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.grey,
//                                   ),
//                                 ),
//                               ),
//                               _buildQuantityButton(
//                                 '+',
//                                 () => cartController.addToCart(item.name, item.price, item.image),
//                               ),
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
//                       onTap: () => _showRemoveConfirmation(item),
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

//   Color _getColorSchemeForItem(CartItem item) {
//     // You can customize this logic based on your needs
//     final colors = [
//       Colors.grey[300]!,
//       Colors.brown[100]!,
//       Colors.red[100]!,
//       Colors.blue[100]!,
//       Colors.green[100]!,
//       Colors.purple[100]!,
//       Colors.orange[100]!,
//     ];
    
//     // Simple hash-based color assignment
//     final index = item.name.hashCode % colors.length;
//     return colors[index.abs()];
//   }

//   Widget _buildQuantityButton(String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
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

//   void _showRemoveConfirmation(CartItem item) {
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(Icons.warning, color: Colors.orange[700], size: 28),
//             const SizedBox(width: 12),
//             const Text('Remove Item'),
//           ],
//         ),
//         content: Text('Are you sure you want to remove "${item.name}" from your cart?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               HapticFeedback.mediumImpact();
//               cartController.removeFromCart(item);
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Remove'),
//           ),
//         ],
//       ),
//       barrierDismissible: true,
//     );
//   }

//   Widget _buildTotalSection() {
//     return Obx(() {
//       final total = cartController.totalPrice;
//       final tax = total * 0.05;
//       final grandTotal = total + tax;
      
//       return AnimatedBuilder(
//         animation: _priceAnimation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _priceAnimation.value,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryColor.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Subtotal',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         'PKR ${total.toInt()}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Tax (5%)',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         'PKR ${tax.toInt()}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         'PKR ${grandTotal.toInt()}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _buildCheckoutButton() {
//     return Obx(() {
//       final hasItems = cartController.cartItems.isNotEmpty;
      
//       return AnimatedBuilder(
//         animation: _cartAnimation,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: 1.0 + (_cartAnimation.value * 0.05),
//             child: GestureDetector(
//               onTap: hasItems ? _goToCheckout : null,
//               child: Container(
//                 width: double.infinity,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: hasItems
//                         ? [
//                             AppColors.primaryColor,
//                             AppColors.primaryColor.withOpacity(0.8),
//                           ]
//                         : [
//                             Colors.grey,
//                             Colors.grey.withOpacity(0.6),
//                           ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: hasItems
//                           ? AppColors.primaryColor.withOpacity(0.3)
//                           : Colors.grey.withOpacity(0.2),
//                       blurRadius: 15,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     hasItems ? 'Go to Checkout' : 'Add Items to Continue',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }

//   void _goToCheckout() {
//     if (cartController.cartItems.isNotEmpty) {
//       HapticFeedback.heavyImpact();
//      Navigator.push(context, MaterialPageRoute(builder: (context){
// return OrderConfirmationScreen();
//      }));
     
//     }
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/model/CartItem.dart';
import 'package:tryon/view/product/OrderConfirmationScreen.dart';
import 'package:tryon/view_model/CartController.dart';
import 'package:tryon/view_model/OrderController.dart';

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

  // GetX Controllers
  final CartController cartController = Get.find<CartController>();
  late final OrderController orderController;

  @override
  void initState() {
    super.initState();
    orderController = Get.put(OrderController());
    
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
              onTap: hasItems ? _showAddressBottomSheet : null,
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
                    hasItems ? 'Proceed to Order' : 'Add Items to Continue',
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

  // New method: Show address input bottom sheet
  void _showAddressBottomSheet() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    // Pre-fill with current user data if available
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      nameController.text = user.displayName ?? '';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your delivery details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Form Fields
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Full Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Order Summary
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Items',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${cartController.cartItems.length} items',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'PKR ${cartController.totalPrice.toInt()}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Obx(() => ElevatedButton.icon(
                        onPressed: orderController.isLoading.value 
                            ? null 
                            : () => _placeOrder(
                                nameController.text,
                                emailController.text,
                                addressController.text,
                              ),
                        icon: orderController.isLoading.value
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Icon(Icons.shopping_bag),
                        label: Text(orderController.isLoading.value 
                            ? 'Placing Order...' 
                            : 'Confirm Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // New method: Place order with address
  Future<void> _placeOrder(String userName, String userEmail, String shippingAddress) async {
    if (userName.isEmpty || userEmail.isEmpty || shippingAddress.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    try {
      // Validate email format
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(userEmail)) {
        Get.snackbar(
          'Error',
          'Please enter a valid email address',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        return;
      }

      // Close bottom sheet
      Get.back();

      // Place the order
      await orderController.placeOrder(
        userName: userName,
        userEmail: userEmail,
        shippingAddress: shippingAddress,
      );

      // Show success screen or navigate to order confirmation
      if (context.mounted) {
        _showOrderSuccessDialog();
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // New method: Show order success dialog
  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop(); // Go back to previous screen
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your order has been confirmed. You will receive a confirmation email shortly.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              LinearProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            ],
          ),
        );
      },
    );
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