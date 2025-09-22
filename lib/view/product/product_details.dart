// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/features/virtual_try_on/views/try_on_screen.dart';
// import 'package:tryon/view_model/CartController.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final String productName;
//   final double productPrice;
//   final String productDescription;
//   final String productImage;
//   final double productRating;
//   ProductDetailsScreen({
//     super.key,
//     required this.productName,
//     required this.productPrice,
//     required this.productDescription,
//     required this.productImage,
//     required this.productRating,
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final CartController cartController = Get.put(CartController());

//   final selectedImageIndex = 0.obs;

//   final cartItemCount = 0.obs;

//   final isAnimating = false.obs;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(children: [_buildProductView(size, context)]),
//       ),
//     );
//   }

//   Widget _buildProductView(Size size, context) {
//     return SizedBox(
//       height: size.height,
//       child: Stack(
//         children: [
//           _buildHeroImage(size),
//           _buildTopBar(size, context),
//           // _buildImageSelector(size),
//           _buildProductDetails(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeroImage(Size size) {
//     final TransformationController _transformationController =
//         TransformationController();
//     final _dragStartOffset = 0.0.obs;

//     return Padding(
//       padding: const EdgeInsets.only(top: 25.0),
//       child: GestureDetector(
//         onVerticalDragStart: (details) {
//           _dragStartOffset.value = details.localPosition.dy;
//         },
//         onVerticalDragUpdate: (details) {
//           if (details.localPosition.dy - _dragStartOffset.value > 100) {
//             Get.back();
//           }
//         },
//         child: InteractiveViewer(
//           transformationController: _transformationController,
//           minScale: 1.0,
//           maxScale: 4.0,
//           child: SizedBox(
//             width: size.width,
//             height: size.height * 0.6,
//             child: AnimatedSwitcher(
//               duration: Duration(milliseconds: 500),
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               child: CachedNetworkImage(
//                 key: ValueKey<int>(0),
//                 imageUrl: widget.productImage,
//                 fit: BoxFit.cover,
//                 width: size.width,
//                 placeholder:
//                     (context, url) => Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: Container(
//                         width: size.width,
//                         height:
//                             size.height * 0.4, // Adjust the height as needed
//                         color: Colors.white,
//                       ),
//                     ),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopBar(Size size, context) {
//     return Positioned(
//       top: size.height * 0.05,
//       left: size.width * 0.04,
//       right: size.width * 0.04,
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [_iconButton(Icons.arrow_back_ios, () => Get.back())],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageThumbnail(Size size, int index) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         margin: EdgeInsets.only(bottom: size.height * 0.01),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color:
//                 selectedImageIndex.value == index
//                     ? AppColors.primaryColor
//                     : Colors.transparent,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: CachedNetworkImage(
//             imageUrl: widget.productImage,
//             width: size.width * 0.11,
//             height: size.height * 0.07,
//             fit: BoxFit.cover,
//             placeholder:
//                 (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Container(
//                     width: size.width * 0.11,
//                     height: size.height * 0.07,
//                     color: Colors.white,
//                   ),
//                 ),
//             errorWidget: (context, url, error) => Icon(Icons.error, size: 20),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductDetails(Size size) {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.45,
//       minChildSize: 0.45,

//       // maxChildSize: 0.95,
//       maxChildSize: 1,
//       builder: (context, scrollController) {
//         return Container(
//           width: size.width,
//           padding: EdgeInsets.all(size.width * 0.04),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     margin: EdgeInsets.only(bottom: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 TweenAnimationBuilder(
//                   tween: Tween<Offset>(
//                     begin: const Offset(0, 1), // Start from bottom
//                     end: const Offset(0, 0), // End at original position
//                   ),
//                   duration: const Duration(milliseconds: 800),
//                   curve: Curves.easeOut,
//                   builder: (context, Offset offset, child) {
//                     return Transform.translate(
//                       offset: offset * 150,
//                       child: AnimatedOpacity(
//                         duration: const Duration(milliseconds: 800),
//                         opacity: 1.0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildProductTitle(size),
//                             SizedBox(height: size.height * 0.006),
//                             _buildPriceSection(size),
//                             SizedBox(height: size.height * 0.01),
//                             SizedBox(height: size.height * 0.01),
//                             _buildDescriptionSection(size),
//                             // SizedBox(height: size.height * 0.015),
//                             SizedBox(height: size.height * 0.02),
//                             _buildAddToCartButton(size, context),
//                             _buildProductSection(size, size.width * 0.06),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProductSection(Size size, double titleFontSize) {
//     return Container(
//       color: Color(0xFFF7F8FA),
//       child: Column(
//         children: [
//           // _buildSectionHeader('Products', RouteName.viewAllProductsScreen, titleFontSize),
//           SizedBox(height: size.height * 0.015),
//           // _buildProductList(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductTitle(Size size) {
//     return Text(
//       widget.productName,
//       style: GoogleFonts.poppins(
//         fontSize: size.width * 0.06,
//         fontWeight: FontWeight.w600,
//         color: AppColors.black, // optional color
//         letterSpacing: 1.2,
//       ),
//     );
//   }

 

//   Widget _buildPriceSection(Size size) {
//     return Text(
//       "PKR ${widget.productPrice.toString()}",
//       style: GoogleFonts.montserrat(
//         fontSize: size.width * 0.07,
//         fontWeight: FontWeight.bold,
//         color: AppColors.black,
//         letterSpacing: 1.5, // gives spacing to look premium
//       ),
//     );
//   }

//   var isDescriptionExpanded = false.obs;

//   Widget _buildDescriptionSection(Size size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           removeHtmlTags(widget.productDescription),
//           style: GoogleFonts.openSans(
//             fontSize: size.width * 0.04,
//             color: Colors.grey[700], // softer grey for readability
//             height: 1.4, // line height for better spacing
//           ),
//           maxLines: isDescriptionExpanded.value ? null : 5,
//           overflow: TextOverflow.fade,
//         ),
//         SizedBox(height: size.height * 0.01),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isDescriptionExpanded.toggle();
//             });
//           },
//           child: Text(
//             isDescriptionExpanded.value ? "Read Less <<" : "Read More >>",
//             style: GoogleFonts.poppins(
//               fontSize: size.width * 0.04,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primaryColor,
//               letterSpacing: 1.1,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String removeHtmlTags(String text) {
//     final RegExp exp = RegExp(
//       r'<[^>]*>',
//       multiLine: true,
//       caseSensitive: false,
//     );
//     return text.replaceAll(exp, '');
//   }

//   Widget _buildAddToCartButton(Size size, context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             width: size.width * 0.4,
//             height: size.height * 0.064,
//             child: ElevatedButton.icon(
//               onPressed: () {
//           cartController.addToCart(
//      widget.productName,
//       widget.productPrice,
//       widget.productImage,
//     ); Get.snackbar(
//       "Added to Cart",
//       "${widget.productName} has been added!",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//               },
//               icon: Icon(Icons.shopping_cart, color: Colors.white),
//               label: Text(
//                 "Add to cart",
//                 style: GoogleFonts.poppins(
//                   fontSize: size.width * 0.042,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                   letterSpacing: 1.2, // makes it look more premium
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),

// SizedBox(
//   width: size.width * 0.4,
//   height: size.height * 0.064,
//   child: InkWell(
//     borderRadius: BorderRadius.circular(12), // ripple matches the shape
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TryOnScreen(garmentImage: widget.productImage),
//         ),
//       );
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//       alignment: Alignment.center,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Image.asset("assets/ai.png",color: Colors.white,height: 30,),
//           Text(
//             "Try it Now",
//             style: GoogleFonts.poppins(
//               fontSize: size.width * 0.042,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//               letterSpacing: 1.2, // premium effect
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// )

//         ],
//       ),
//     );
//   }

//   Widget _iconButton(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//         child: Icon(icon, color: Colors.black),
//       ),
//     );
//   }
// }



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/features/virtual_try_on/views/try_on_screen.dart';
// import 'package:tryon/view_model/CartController.dart';
// import 'package:tryon/view_model/FavoritesController.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final String productName;
//   final double productPrice;
//   final String productDescription;
//   final String productImage;
//   final double productRating;
//   final String productId; // Add productId for favorites

//   ProductDetailsScreen({
//     super.key,
//     required this.productName,
//     required this.productPrice,
//     required this.productDescription,
//     required this.productImage,
//     required this.productRating,
//     required this.productId, // Make it required or provide default
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final CartController cartController = Get.put(CartController());
//   final FavoritesController favoritesController = Get.put(FavoritesController()); // Get the favorites controller

//   final selectedImageIndex = 0.obs;
//   final cartItemCount = 0.obs;
//   final isAnimating = false.obs;
  
//   // Reactive variable to track if current product is favorite
//   final RxBool isFavorite = false.obs;

//   @override
//   void initState() {
//     super.initState();
//     // Check if product is already in favorites
//     _checkIfFavorite();
//   }

//   void _checkIfFavorite() {
//     final product = {
//       'id': widget.productId,
//       'name': widget.productName,
//       'price': widget.productPrice,
//       'image': widget.productImage,
//       'rating': widget.productRating,
//     };
//     // isFavorite.value = favoritesController.isProductFavorite(widget.productId);
//   }

//   void _toggleFavorite() {
    
//     Product product=Product(id:1, name: widget.productName, imageUrl: widget.productImage, price: widget.productPrice.toString());
    
//     if (isFavorite.value) {
//       // Remove from favorites
//       favoritesController.toggleFavorite(product);
//       Get.snackbar(
//         "Removed",
//         "${widget.productName} removed from favorites",
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.red.withOpacity(0.1),
//         colorText: Colors.red,
//         duration: Duration(milliseconds: 1500),
//       );
//     } else {
//       // Add to favorites
//       favoritesController.addFavorite(product);
//       Get.snackbar(
//         "Added",
//         "${widget.productName} added to favorites",
//         snackPosition: SnackPosition.TOP,
//         // backgroundColor: Colors.pink.withOpacity(0.1),
//         // colorText: Colors.pink,
//         duration: Duration(milliseconds: 1500),
//       );
//     }
    
//     // Update the reactive state
//     isFavorite.value = !isFavorite.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(children: [_buildProductView(size, context)]),
//       ),
//     );
//   }

//   Widget _buildProductView(Size size, context) {
//     return SizedBox(
//       height: size.height,
//       child: Stack(
//         children: [
//           _buildHeroImage(size),
//           _buildTopBar(size, context),
//           // _buildImageSelector(size),
//           _buildProductDetails(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeroImage(Size size) {
//     final TransformationController _transformationController =
//         TransformationController();
//     final _dragStartOffset = 0.0.obs;

//     return Padding(
//       padding: const EdgeInsets.only(top: 25.0),
//       child: GestureDetector(
//         onVerticalDragStart: (details) {
//           _dragStartOffset.value = details.localPosition.dy;
//         },
//         onVerticalDragUpdate: (details) {
//           if (details.localPosition.dy - _dragStartOffset.value > 100) {
//             Get.back();
//           }
//         },
//         child: InteractiveViewer(
//           transformationController: _transformationController,
//           minScale: 1.0,
//           maxScale: 4.0,
//           child: SizedBox(
//             width: size.width,
//             height: size.height * 0.6,
//             child: AnimatedSwitcher(
//               duration: Duration(milliseconds: 500),
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               child: CachedNetworkImage(
//                 key: ValueKey<int>(0),
//                 imageUrl: widget.productImage,
//                 fit: BoxFit.cover,
//                 width: size.width,
//                 placeholder:
//                     (context, url) => Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: Container(
//                         width: size.width,
//                         height:
//                             size.height * 0.4, // Adjust the height as needed
//                         color: Colors.white,
//                       ),
//                     ),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTopBar(Size size, context) {
//     return Positioned(
//       top: size.height * 0.05,
//       left: size.width * 0.04,
//       right: size.width * 0.04,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _iconButton(Icons.arrow_back_ios, () => Get.back()),
//           // Favorite Icon
//           Obx(() => GestureDetector(
//             onTap: _toggleFavorite,
//             child: Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 isFavorite.value ? Icons.favorite : Icons.favorite_border,
//                 color: isFavorite.value ? Colors.red : Colors.grey,
//                 size: 24,
//               ),
//             ),
//           )),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageThumbnail(Size size, int index) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         margin: EdgeInsets.only(bottom: size.height * 0.01),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color:
//                 selectedImageIndex.value == index
//                     ? AppColors.primaryColor
//                     : Colors.transparent,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: CachedNetworkImage(
//             imageUrl: widget.productImage,
//             width: size.width * 0.11,
//             height: size.height * 0.07,
//             fit: BoxFit.cover,
//             placeholder:
//                 (context, url) => Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Container(
//                     width: size.width * 0.11,
//                     height: size.height * 0.07,
//                     color: Colors.white,
//                   ),
//                 ),
//             errorWidget: (context, url, error) => Icon(Icons.error, size: 20),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProductDetails(Size size) {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.45,
//       minChildSize: 0.45,
//       maxChildSize: 1,
//       builder: (context, scrollController) {
//         return Container(
//           width: size.width,
//           padding: EdgeInsets.all(size.width * 0.04),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     margin: EdgeInsets.only(bottom: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 TweenAnimationBuilder(
//                   tween: Tween<Offset>(
//                     begin: const Offset(0, 1), // Start from bottom
//                     end: const Offset(0, 0), // End at original position
//                   ),
//                   duration: const Duration(milliseconds: 800),
//                   curve: Curves.easeOut,
//                   builder: (context, Offset offset, child) {
//                     return Transform.translate(
//                       offset: offset * 150,
//                       child: AnimatedOpacity(
//                         duration: const Duration(milliseconds: 800),
//                         opacity: 1.0,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildProductTitle(size),
//                             SizedBox(height: size.height * 0.006),
//                             _buildPriceSection(size),
//                             SizedBox(height: size.height * 0.01),
//                             SizedBox(height: size.height * 0.01),
//                             _buildRatingSection(size),
//                             SizedBox(height: size.height * 0.01),
//                             _buildDescriptionSection(size),
//                             SizedBox(height: size.height * 0.02),
//                             _buildAddToCartButton(size, context),
//                             _buildProductSection(size, size.width * 0.06),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Added rating section
//   Widget _buildRatingSection(Size size) {
//     return Row(
//       children: [
//         Icon(
//           Icons.star,
//           color: Colors.amber,
//           size: size.width * 0.05,
//         ),
//         SizedBox(width: size.width * 0.01),
//         Text(
//           '${widget.productRating.toStringAsFixed(1)}',
//           style: GoogleFonts.poppins(
//             fontSize: size.width * 0.045,
//             fontWeight: FontWeight.w500,
//             color: AppColors.black,
//           ),
//         ),
//         Text(
//           ' (${(widget.productRating * 10).round()} reviews)',
//           style: GoogleFonts.poppins(
//             fontSize: size.width * 0.035,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductSection(Size size, double titleFontSize) {
//     return Container(
//       color: Color(0xFFF7F8FA),
//       child: Column(
//         children: [
//           // _buildSectionHeader('Products', RouteName.viewAllProductsScreen, titleFontSize),
//           SizedBox(height: size.height * 0.015),
//           // _buildProductList(size),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductTitle(Size size) {
//     return Text(
//       widget.productName,
//       style: GoogleFonts.poppins(
//         fontSize: size.width * 0.06,
//         fontWeight: FontWeight.w600,
//         color: AppColors.black, // optional color
//         letterSpacing: 1.2,
//       ),
//     );
//   }

//   Widget _buildPriceSection(Size size) {
//     return Text(
//       "PKR ${widget.productPrice.toString()}",
//       style: GoogleFonts.montserrat(
//         fontSize: size.width * 0.07,
//         fontWeight: FontWeight.bold,
//         color: AppColors.black,
//         letterSpacing: 1.5, // gives spacing to look premium
//       ),
//     );
//   }

//   var isDescriptionExpanded = false.obs;

//   Widget _buildDescriptionSection(Size size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           removeHtmlTags(widget.productDescription),
//           style: GoogleFonts.openSans(
//             fontSize: size.width * 0.04,
//             color: Colors.grey[700], // softer grey for readability
//             height: 1.4, // line height for better spacing
//           ),
//           maxLines: isDescriptionExpanded.value ? null : 5,
//           overflow: TextOverflow.fade,
//         ),
//         SizedBox(height: size.height * 0.01),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isDescriptionExpanded.toggle();
//             });
//           },
//           child: Text(
//             isDescriptionExpanded.value ? "Read Less <<" : "Read More >>",
//             style: GoogleFonts.poppins(
//               fontSize: size.width * 0.04,
//               fontWeight: FontWeight.w600,
//               color: AppColors.primaryColor,
//               letterSpacing: 1.1,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String removeHtmlTags(String text) {
//     final RegExp exp = RegExp(
//       r'<[^>]*>',
//       multiLine: true,
//       caseSensitive: false,
//     );
//     return text.replaceAll(exp, '');
//   }

//   Widget _buildAddToCartButton(Size size, context) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             width: size.width * 0.4,
//             height: size.height * 0.064,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 cartController.addToCart(
//                   widget.productName,
//                   widget.productPrice,
//                   widget.productImage,
//                 );
//                 Get.snackbar(
//                   "Added to Cart",
//                   "${widget.productName} has been added!",
//                   snackPosition: SnackPosition.BOTTOM,
//                 );
//               },
//               icon: Icon(Icons.shopping_cart, color: Colors.white),
//               label: Text(
//                 "Add to cart",
//                 style: GoogleFonts.poppins(
//                   fontSize: size.width * 0.042,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                   letterSpacing: 1.2, // makes it look more premium
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: size.width * 0.4,
//             height: size.height * 0.064,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12), // ripple matches the shape
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TryOnScreen(garmentImage: widget.productImage),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Image.asset("assets/ai.png", color: Colors.white, height: 30),
//                     Text(
//                       "Try it Now",
//                       style: GoogleFonts.poppins(
//                         fontSize: size.width * 0.042,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                         letterSpacing: 1.2, // premium effect
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _iconButton(IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//         child: Icon(icon, color: Colors.black),
//       ),
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/features/virtual_try_on/views/try_on_screen.dart';
import 'package:tryon/view_model/CartController.dart';
import 'package:tryon/view_model/FavoritesController.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final String productImage;
  final double productRating;
  final String productId;

  ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
    required this.productRating,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartController cartController = Get.put(CartController());
  final FavoritesController favoritesController = Get.put(FavoritesController());

  final selectedImageIndex = 0.obs;
  final cartItemCount = 0.obs;
  final isAnimating = false.obs;
  final RxBool isFavorite = false.obs;

  // Expanded states for dropdown sections
  final RxBool isProductDetailExpanded = true.obs;
  final RxBool isMaterialCareExpanded = false.obs;
  final RxBool isReviewExpanded = false.obs;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    // Your favorite checking logic
  }

  void _toggleFavorite() {
    // Your favorite toggle logic
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [_buildProductView(size, context)]),
      ),
    );
  }

  Widget _buildProductView(Size size, context) {
    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          _buildHeroImage(size),
          _buildTopBar(size, context),
          _buildProductDetails(size),
        ],
      ),
    );
  }

  Widget _buildHeroImage(Size size) {
    final TransformationController _transformationController =
        TransformationController();
    final _dragStartOffset = 0.0.obs;

    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: GestureDetector(
        onVerticalDragStart: (details) {
          _dragStartOffset.value = details.localPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          if (details.localPosition.dy - _dragStartOffset.value > 100) {
            Get.back();
          }
        },
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 1.0,
          maxScale: 4.0,
          child: SizedBox(
            width: size.width,
            height: size.height * 0.6,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: CachedNetworkImage(
                key: ValueKey<int>(0),
                imageUrl: widget.productImage,
                fit: BoxFit.cover,
                width: size.width,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.4,
                        color: Colors.white,
                      ),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Size size, context) {
    return Positioned(
      top: size.height * 0.05,
      left: size.width * 0.04,
      right: size.width * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(Icons.arrow_back_ios, () => Get.back()),
          Obx(() => GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isFavorite.value ? Icons.favorite : Icons.favorite_border,
                color: isFavorite.value ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProductDetails(Size size) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          width: size.width,
          padding: EdgeInsets.all(size.width * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                  tween: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0),
                  ),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, Offset offset, child) {
                    return Transform.translate(
                      offset: offset * 150,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProductTitle(size),
                            SizedBox(height: size.height * 0.006),
                            _buildPriceSection(size),
                            SizedBox(height: size.height * 0.01),
                            _buildRatingSection(size),
                            SizedBox(height: size.height * 0.02),
                            
                            // Product Detail Section
                            _buildExpandableSection(
                              title: "Product Detail",
                              isExpanded: isProductDetailExpanded,
                              content: _buildProductDetailContent(),
                            ),
                            SizedBox(height: size.height * 0.02),
                            
                            // Material and Care Section
                            _buildExpandableSection(
                              title: "Material and care",
                              isExpanded: isMaterialCareExpanded,
                              content: _buildMaterialCareContent(),
                            ),
                            SizedBox(height: size.height * 0.02),
                            
                            // Review Section
                            _buildExpandableSection(
                              title: "Review",
                              isExpanded: isReviewExpanded,
                              content: _buildReviewContent(),
                            ),
                            SizedBox(height: size.height * 0.02),
                            
                            _buildAddToCartButton(size, context),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required RxBool isExpanded,
    required Widget content,
  }) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header with dropdown button
          ListTile(
            title: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            trailing: Icon(
              isExpanded.value ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey.shade600,
            ),
            onTap: () {
              isExpanded.toggle();
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          
          // Content
          if (isExpanded.value)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: content,
            ),
        ],
      ),
    ));
  }

  Widget _buildProductDetailContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
     widget. productDescription,
         style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCareContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "100% Cotton\nMachine washable\nDo not bleach\nTumble dry low\nIron on low heat\nDry cleanable",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall rating
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 8),
            Text(
              "5.0",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          "Based on 128 reviews",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 16),
        
        // Sample review
        _buildReviewItem(
          userName: "John Doe",
          rating: 5,
          date: "2 weeks ago",
          comment: "Excellent quality! Fits perfectly and looks great. Highly recommended!",
        ),
        SizedBox(height: 12),
        
        _buildReviewItem(
          userName: "Sarah Smith",
          rating: 5,
          date: "1 month ago",
          comment: "Love this jacket! The material is durable and it's very comfortable.",
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String userName,
    required int rating,
    required String date,
    required String comment,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) => Icon(
              Icons.star,
              color: index < rating ? Colors.amber : Colors.grey.shade300,
              size: 16,
            )),
          ),
          SizedBox(height: 8),
          Text(
            comment,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(Size size) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: size.width * 0.05,
        ),
        SizedBox(width: size.width * 0.01),
        Text(
          '${widget.productRating.toStringAsFixed(1)}',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        Text(
          ' (${(widget.productRating * 10).round()} reviews)',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.035,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProductTitle(Size size) {
    return Text(
      widget.productName,
      style: GoogleFonts.poppins(
        fontSize: size.width * 0.06,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildPriceSection(Size size) {
    return Text(
      "PKR ${widget.productPrice.toString()}",
      style: GoogleFonts.montserrat(
        fontSize: size.width * 0.07,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildAddToCartButton(Size size, context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.4,
            height: size.height * 0.064,
            child: ElevatedButton.icon(
              onPressed: () {
                cartController.addToCart(
                  widget.productName,
                  widget.productPrice,
                  widget.productImage,
                );
                Get.snackbar(
                  "Added to Cart",
                  "${widget.productName} has been added!",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: Text(
                "Add to cart",
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.4,
            height: size.height * 0.064,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TryOnScreen(garmentImage: widget.productImage),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/ai.png", color: Colors.white, height: 30),
                    Text(
                      "Try it Now",
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}