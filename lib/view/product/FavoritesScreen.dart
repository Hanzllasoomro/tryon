// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:tryon/constant/app_colors.dart';

// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;

//   // Sample favorite products data
//   final List<Map<String, dynamic>> favoriteProducts = [
//     {
//       'id': '1',
//       'name': 'Wireless Headphones',
//       'price': 89.99,
//       'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
//       'rating': 4.5,
//       'isFavorite': true,
//     },
//     {
//       'id': '2',
//       'name': 'Smart Watch Series 5',
//       'price': 199.99,
//       'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1099&q=80',
//       'rating': 4.8,
//       'isFavorite': true,
//     },
//     {
//       'id': '3',
//       'name': 'Running Shoes',
//       'price': 129.99,
//       'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
//       'rating': 4.3,
//       'isFavorite': true,
//     },
//     {
//       'id': '4',
//       'name': 'Designer Backpack',
//       'price': 79.99,
//       'image': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
//       'rating': 4.6,
//       'isFavorite': true,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
    
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
    
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//       ),
//     );
    
//     _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
//       ),
//     );
    
//     // Start animation after build
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       _animationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _toggleFavorite(int index) {
//     setState(() {
//       favoriteProducts[index]['isFavorite'] = 
//           !favoriteProducts[index]['isFavorite'];
//     });
    
//     // If product is unfavorited, remove it from the list after a short delay
//     if (!favoriteProducts[index]['isFavorite']) {
//       Future.delayed(const Duration(milliseconds: 300), () {
//         if (mounted) {
//           setState(() {
//             favoriteProducts.removeAt(index);
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnimatedBuilder(
//         animation: _animationController,
//         builder: (context, child) {
//           return FadeTransition(
//             opacity: _fadeAnimation,
//             child: Transform.translate(
//               offset: Offset(0, _slideAnimation.value),
//               child: child,
//             ),
//           );
//         },
//         child: CustomScrollView(
//           slivers: [
//             // App bar with title
//             SliverAppBar(
//               expandedHeight: 140,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text(
//                   'My Favorites',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 4,
//                         color: Colors.black.withOpacity(0.3),
//                         offset: const Offset(1, 1),
//                       ),
//                     ],
//                   ),
//                 ),
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [AppColors.primaryColor, AppColors.yellow],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Decorative elements
//                       Positioned(
//                         top: 20,
//                         right: 20,
//                         child: Opacity(
//                           opacity: 0.1,
//                           child: Icon(Icons.favorite_border, 
//                               size: 100, color: Colors.white),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         left: 30,
//                         child: Opacity(
//                           opacity: 0.1,
//                           child: Icon(Icons.shopping_bag_outlined, 
//                               size: 80, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             // Products grid or empty state
//             if (favoriteProducts.isEmpty)
//               SliverFillRemaining(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.favorite_border,
//                       size: 80,
//                       color: Colors.grey.withOpacity(0.5),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'No favorites yet',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey.withOpacity(0.7),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Start adding items to your favorites!',
//                       style: TextStyle(
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Navigate to products screen
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                       ),
//                       child: const Text('Browse Products'),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               SliverPadding(
//                 padding: const EdgeInsets.all(16),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.7,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       final product = favoriteProducts[index];
//                       return _buildProductCard(product, index);
//                     },
//                     childCount: favoriteProducts.length,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard(Map<String, dynamic> product, int index) {
//     return Material(
//       borderRadius: BorderRadius.circular(16),
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           // Navigate to product detail
//         },
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product image
//                   ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16),
//                     ),
//                     child: Image.network(
//                       product['image'],
//                       height: 150,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           height: 150,
//                           color: Colors.grey.shade200,
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               value: loadingProgress.expectedTotalBytes != null
//                                   ? loadingProgress.cumulativeBytesLoaded /
//                                       loadingProgress.expectedTotalBytes!
//                                   : null,
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
                  
//                   // Product details
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product['name'],
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.grey,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         // Rating
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: AppColors.yellow,
//                               size: 16,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               product['rating'].toString(),
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '\$${product['price'].toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
              
//               // Favorite button
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: InkWell(
//                   onTap: () => _toggleFavorite(index),
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       product['isFavorite'] 
//                           ? Icons.favorite 
//                           : Icons.favorite_border,
//                       color: product['isFavorite'] 
//                           ? Colors.red 
//                           : Colors.grey,
//                       size: 20,
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
// }