// First, update the existing CartItem model to include toMap and fromMap for Firebase serialization.
// Assuming the CartItem model looks like this (based on usage in the code):
// File: lib/model/CartItem.dart

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tryon/model/order_model.dart';
class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'orders';

  // Create a new order in Firebase
  Future<String> createOrder(OrderModel order) async {
    try {
      final docRef = await _firestore.collection(_collection).add(order.toMap());
      return docRef.id; // Return the generated order ID
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Optional: Fetch orders for a user (for future use, e.g., order history)
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.id, doc.data());
      }).toList();
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch orders: $e');
    }
  }

Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .orderBy('orderDate', descending: true)
          .get();
      
      return querySnapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.id, doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch all orders: $e');
    }
  }
// Add updateOrderStatus method
Future<void> updateOrderStatus(String orderId, String newStatus) async {
  try {
    await _firestore.collection(_collection).doc(orderId).update({
      'status': newStatus,
    });
    fetchAllOrders(); // Refresh list
    Get.snackbar('Success', 'Order status updated to $newStatus');
  } catch (e) {
    Get.snackbar('Error', 'Failed to update status: $e');
  }
}

// Update OrderRepository.dart to add getAllOrders
// Add this method to OrderRepository class:
Future<List<OrderModel>> getAllOrders() async {
  try {
    final querySnapshot = await _firestore
        .collection(_collection)
        .orderBy('orderDate', descending: true)
        .get();
    
    return querySnapshot.docs.map((doc) {
      return OrderModel.fromMap(doc.id, doc.data());
    }).toList();
  } catch (e) {
    throw Exception('Failed to fetch all orders: $e');
  }
}


}