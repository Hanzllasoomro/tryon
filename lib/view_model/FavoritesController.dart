// favorites_controller.dart
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favoriteProducts = <Map<String, dynamic>>[].obs;

  void addToFavorites(Map<String, dynamic> product) {
    final existingIndex = favoriteProducts.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex == -1) {
      favoriteProducts.add({
        'id': product['id'],
        'name': product['name'],
        'price': product['price'],
        'image': product['image'],
        'rating': product['rating'],
        'isFavorite': true,
      });
    }
  }

  void removeFromFavorites(String id) {
    favoriteProducts.removeWhere((item) => item['id'] == id);
  }

  void toggleFavorite(String id) {
    final index = favoriteProducts.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      final isFavorite = !favoriteProducts[index]['isFavorite'];
      favoriteProducts[index]['isFavorite'] = isFavorite;
      if (!isFavorite) {
        Future.delayed(const Duration(milliseconds: 300), () {
          removeFromFavorites(id);
        });
      }
      favoriteProducts.refresh();
    }
  }
}