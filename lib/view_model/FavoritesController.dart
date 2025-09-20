// // favorites_controller.dart
// import 'package:get/get.dart';

// class FavoritesController extends GetxController {
//   var favoriteProducts = <Map<String, dynamic>>[].obs;

//   void addToFavorites(Map<String, dynamic> product) {
//     final existingIndex = favoriteProducts.indexWhere((item) => item['id'] == product['id']);
//     if (existingIndex == -1) {
//       favoriteProducts.add({
//         'id': product['id'],
//         'name': product['name'],
//         'price': product['price'],
//         'image': product['image'],
//         'rating': product['rating'],
//         'isFavorite': true,
//       });
//     }
//   }

//   void removeFromFavorites(String id) {
//     favoriteProducts.removeWhere((item) => item['id'] == id);
//   }

//   void toggleFavorite(String id) {
//     final index = favoriteProducts.indexWhere((item) => item['id'] == id);
//     if (index != -1) {
//       final isFavorite = !favoriteProducts[index]['isFavorite'];
//       favoriteProducts[index]['isFavorite'] = isFavorite;
//       if (!isFavorite) {
//         Future.delayed(const Duration(milliseconds: 300), () {
//           removeFromFavorites(id);
//         });
//       }
//       favoriteProducts.refresh();
//     }
//   }
// }

import 'package:get/get.dart';

class Product {
  final int id;
  final String name;
  final String imageUrl;

  final String price;
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  // optional equality check (so remove works properly)
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class FavoritesController extends GetxController {
  // Reactive list of Product models
  final RxList<Product> favoriteProducts = <Product>[].obs;

  /// Toggle a product's favorite status
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }

  /// Add a product to favorites
  void addFavorite(Product product) {
    if (!isFavorite(product)) {
      favoriteProducts.add(product);
    }
  }

  /// Remove a product from favorites
  void removeFavorite(Product product) {
    favoriteProducts.remove(product);
  }

  /// Check if a product is already in favorites
  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }

  /// Clear all favorites
  void clearFavorites() {
    favoriteProducts.clear();
  }
}
