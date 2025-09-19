import 'package:get/get.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/model/CartItem.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(String name, double price, String imagePath) {
    // Check if product already exists
    int index = cartItems.indexWhere((item) => item.name == name);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(CartItem(name: name, price: price, image: imagePath,quantity: 1,color:""));
    }
  }

  void removeFromCart(CartItem item) {
    if (item.quantity > 1) {
      item.quantity -= 1;
      cartItems.refresh(); // refresh UI
    } else {
      cartItems.remove(item);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
