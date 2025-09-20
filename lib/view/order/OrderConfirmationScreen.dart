
// Example OrderConfirmationScreen.dart (you may need to create or update this screen)
// File: lib/view/product/OrderConfirmationScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/repository/order_repo/order_repo.dart';
import 'package:tryon/view_model/OrderController.dart';
class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final OrderController orderController = Get.put(OrderController());

  // Form fields for user details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Shipping Address'),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: orderController.isLoading.value
                  ? null
                  : () => orderController.placeOrder(
                        userName: nameController.text,
                        userEmail: emailController.text,
                        shippingAddress: addressController.text,
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: orderController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Place Order'),
            )),
          ],
        ),
      ),
    );
  }
}