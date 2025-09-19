// class CartItem {
//   final String name;
//   final double price;
//   final String imagePath;
//   int quantity;

//   CartItem({
//     required this.name,
//     required this.price,
//     required this.imagePath,
//     this.quantity = 1,
//   });
// }


import 'dart:ui';

class CartItem {
  final String image;
  final String name;

   int quantity;
  final String color;
  final double price;
  // final Color colorScheme;

  CartItem({
    required this.image,
    required this.quantity,
    required this.name,
    required this.color,
    required this.price,
    // required this.colorScheme,
  });
}