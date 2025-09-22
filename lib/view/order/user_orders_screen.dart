// // File: lib/view/user_orders/user_orders_screen.dart
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/model/CartItem.dart';
// import 'package:tryon/model/order_model.dart';
// import 'package:tryon/view_model/OrderController.dart';


// class OrdersScreen extends StatelessWidget {
//   final String userId;
//   final OrderController controller = Get.put(OrderController());

//   OrdersScreen({super.key, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchOrders(userId);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Orders"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.orders.isEmpty) {
//           return const Center(child: Text("No orders found"));
//         }
//         return ListView.builder(
//           itemCount: controller.orders.length,
//           itemBuilder: (context, index) {
//             final order = controller.orders[index];
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: ListTile(
//                 title: Text("Order #${order.id}"),
//                 subtitle: Text(
//   "Date: ${order.orderDate.toLocal().toString().split(' ')[0]}\n"
//   "Total: \$${order.totalAmount.toStringAsFixed(2)}",
// ),

//                 trailing: const Icon(Icons.arrow_forward_ios),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryon/model/CartItem.dart';
import 'package:tryon/model/order_model.dart';
import 'package:tryon/view_model/OrderController.dart';
import 'package:tryon/constant/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  final String userId;
  final OrderController controller = Get.put(OrderController());

  OrdersScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    controller.fetchOrders(userId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildLoadingState();
                }
                if (controller.orders.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildOrdersList();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            Color(0xFFFF6B00),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              SizedBox(width: 8),
              Text(
                "My Orders",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            "Loading your orders...",
            style: GoogleFonts.poppins(
              color: AppColors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
          SizedBox(height: 16),
          Text(
            "No Orders Yet",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Your orders will appear here",
            style: GoogleFonts.poppins(
              color: AppColors.grey.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Start Shopping",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: controller.orders.length,
      itemBuilder: (context, index) {
        final order = controller.orders[index];
        return _buildOrderCard(order, index);
      },
    );
  }

  Widget _buildOrderCard(OrderModel order, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeOut,
      margin: EdgeInsets.only(bottom: 16),
      transform: Matrix4.translationValues(0, index == 0 ? 0 : 20, 0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey[50]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    Color(0xFFFF6B00),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Text(
              "Order #${order.id?.substring(0, 8) ?? 'N/A'}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.black,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  "Date: ${order.orderDate.toLocal().toString().split(' ')[0]}",
                  style: GoogleFonts.poppins(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                _buildStatusChip(order.status),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PKR ${order.totalAmount.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  "${order.products.length} items",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
            children: [
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Order ID:", order.id ?? 'N/A'),
                    _buildInfoRow("Customer:", order.userName),
                    _buildInfoRow("Email:", order.userEmail),
                    _buildInfoRow("Address:", order.shippingAddress),
                    SizedBox(height: 12),
                    Text(
                      "Products:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...order.products.map((product) => _buildProductItem(product)),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount:",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            "PKR ${order.totalAmount.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'shipped':
        statusColor = Colors.blue;
        break;
      case 'pending':
        statusColor = AppColors.yellow;
        break;
      default:
        statusColor = AppColors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(CartItem product) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.inventory_2, color: AppColors.primaryColor, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Text(
                //   "Size: ${product.size}, Qty: ${product.quantity}",
                //   style: GoogleFonts.poppins(
                //     fontSize: 10,
                //     color: AppColors.grey,
                //   ),
                // ),
              ],
            ),
          ),
          Text(
            "PKR ${(double.tryParse(product.price.toString()) ?? 0).toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}