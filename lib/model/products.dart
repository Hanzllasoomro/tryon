// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class products extends StatefulWidget {
//   final String image1;
//   final String name;
//   final String price;
//   final double price1;
//   final String kg;

//   const products({
//     super.key,
//     required this.image1,
//     required this.name,
//     required this.price,
//     required this.price1,
//     required this.kg,
//   });

//   @override
//   State<products> createState() => _ProductState();
// }

// class _ProductState extends State<products> {

//   void addToCart(String name, double price, String imagePath) {

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 174,
//       height: 248,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(color: Colors.blueGrey.withOpacity(0.3), spreadRadius: 0.4),
//         ],
//         border: Border.all(color: Colors.blueGrey, width: 0.7),
//       ),
//       child: Column(
//         children: [
//           Expanded(child: Image.network(widget.image1)),

//           // Expanded(child: Image.asset(widget.image1,)),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     widget.kg,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: const Color(0xff7C7C7C),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.price,
//                         style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                       FloatingActionButton(
//                         onPressed: () {
//                           // Add to local and database cart
//                           addToCart(widget.name, widget.price1, widget.image1);
//                         },
//                         backgroundColor: const Color(0xff53B175),
//                         child: const Icon(Icons.add, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryon/constant/app_colors.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;
  final double priceValue;
  final String weight;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.priceValue,
    required this.weight,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void addToCart(String name, double price, String imagePath) {
    // Your add to cart implementation
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 174,
      height: 248,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.3),
            spreadRadius: 0.4,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Product image as background
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.0, 0.5, 0.8, 1.0],
              ),
            ),
          ),

          // Product details positioned on the image
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.weight,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          addToCart(
                            widget.name,
                            widget.priceValue,
                            widget.imageUrl,
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Optional: Top-right favorite icon
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 18,
                color: Colors.black54,
              ),
            ),
          ),

          // Optional: Discount badge
          if (widget.priceValue > 50) // Example condition
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "SALE",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
