

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tryon/model/order_model.dart';
import 'package:tryon/repository/order_repo/order_repo.dart';
import 'package:tryon/view_model/CartController.dart';

class OrderController extends GetxController {
  final OrderRepository _repository = OrderRepository();
  final CartController _cartController =Get.put(CartController());
  var orders = <OrderModel>[].obs;

final RxList<OrderModel> allOrders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<OrderModel> userOrders = <OrderModel>[].obs;

  // Place an order
  Future<void> placeOrder({
    required String userName,
    required String userEmail,
    required String shippingAddress,
  }) async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final order = OrderModel(
        userId: user.uid,
        userName: userName,
        userEmail: userEmail,
        shippingAddress: shippingAddress,
        products: _cartController.cartItems,
        totalAmount: _cartController.totalPrice,
        orderDate: DateTime.now(),
        status: 'pending',
      );

      final orderId = await _repository.createOrder(order);
      
      // Clear the cart after successful order
      _cartController.clearCart();

      // Optionally, fetch updated orders
      await fetchUserOrders();

      Get.snackbar(
        'Success',
        'Order placed successfully! Order ID: $orderId',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  /// ✅ Fetch all orders for a specific user
  Future<void> fetchOrders(String userId) async {
    try {
      isLoading.value = true;

      final snapshot = await FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: userId)
          .orderBy("orderDate", descending: true)
          .get();

      orders.value = snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Fetch user's orders
  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final orders = await _repository.getUserOrders(user.uid);
      userOrders.assignAll(orders);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch orders: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      // Update the order in Firestore
      await _repository.updateOrderStatus(orderId, newStatus);
      
      // Refresh the orders list to reflect the change
      await fetchAllOrders();
      
      // Show success message
      Get.snackbar(
        'Success',
        'Order status updated to ${newStatus.toUpperCase()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        'Failed to update order status: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
Future<void> fetchAllOrders() async {
  try {
    isLoading.value = true;
    final orders = await _repository.getAllOrders();
    allOrders.assignAll(orders);
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch orders: $e');
  } finally {
    isLoading.value = false;
  }
}


}
