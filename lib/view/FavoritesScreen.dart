// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/view_model/FavoritesController.dart';

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

//   // GetX Controller
//   final FavoritesController favoritesController = Get.find<FavoritesController>();

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

//   void _toggleFavorite(String id) {
//     favoritesController.toggleFavorite(id);
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
//             Obx(() => favoritesController.favoriteProducts.isEmpty
//               ? SliverFillRemaining(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.favorite_border,
//                         size: 80,
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'No favorites yet',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey.withOpacity(0.7),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Start adding items to your favorites!',
//                         style: TextStyle(
//                           color: Colors.grey.withOpacity(0.5),
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigate to products screen
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 12),
//                         ),
//                         child: const Text('Browse Products',style: TextStyle(color: Colors.white),),
//                       ),
//                     ],
//                   ),
//                 )
//               : SliverPadding(
//                   padding: const EdgeInsets.all(16),
//                   sliver: SliverGrid(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 0.7,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         final product = favoritesController.favoriteProducts[index];
//                         return _buildProductCard(product, index);
//                       },
//                       childCount: favoritesController.favoriteProducts.length,
//                     ),
//                   ),
//                 ),
//             ),
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
//                   onTap: () => _toggleFavorite(product['id']),
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


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view_model/FavoritesController.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // GetX Controller
  late final FavoritesController favoritesController;

  @override
  void initState() {
    super.initState();
    
    // Initialize controller
    favoritesController = Get.put(FavoritesController());
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Start animation after build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite(Product id) {
    favoritesController.toggleFavorite(id);
  }


  void _navigateToProducts() {
    // Navigate to products screen
    // Get.toNamed('/products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: child,
            ),
          );
        },
        child: CustomScrollView(
          slivers: [
            // App bar with title
            SliverAppBar(
              expandedHeight: 140,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Obx(() => Text(
                  '${favoritesController.favoriteProducts.length} Favorites',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                )),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.yellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative elements
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.favorite_border, 
                              size: 100, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 30,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.shopping_bag_outlined, 
                              size: 80, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Products grid or empty state
            Obx(() {
              final activeFavorites = favoritesController.favoriteProducts
                  .toList();
                  
              return activeFavorites.isEmpty
                  ? SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 80,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No favorites yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start adding items to your favorites!',
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _navigateToProducts,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text(
                              'Browse Products',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = activeFavorites[index];
                            return _buildProductCard(product);
                          },
                          childCount: activeFavorites.length,
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    // final isFavorite = product['isFavorite'] == true;
    
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: InkWell(
        // onTap: () => _navigateToProductDetail(product),

        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Product details
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name?? 'Unknown Product',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Rating
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.star,
                        //       color: AppColors.yellow,
                        //       size: 16,
                        //     ),
                        //     const SizedBox(width: 4),
                        //     Text(
                        //       (4).toStringAsFixed(1),
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.grey.shade600,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${(product.price)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () => _toggleFavorite(product),
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite ,
                      color:   Colors.red ,
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
  }
}