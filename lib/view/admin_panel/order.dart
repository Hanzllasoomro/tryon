// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/model/CartItem.dart';
// import 'package:tryon/model/order_model.dart';
// import 'package:tryon/view/admin_panel/order.dart';
// import 'package:tryon/view_model/OrderController.dart';

// class AdminOrdersScreen extends StatefulWidget {
//   const AdminOrdersScreen({super.key});

//   @override
//   State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
// }

// class _AdminOrdersScreenState extends State<AdminOrdersScreen>
//     with TickerProviderStateMixin {
//   late final OrderController orderController;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   // For search and filter
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedStatus = 'All';
//   final List<String> _statusOptions = ['All', 'pending', 'shipped', 'delivered'];

//   @override
//   void initState() {
//     super.initState();
//     orderController = Get.put(OrderController());
//     orderController.fetchAllOrders(); // We'll add this method

//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
//     );
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           _buildAppBar(),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   _buildSearchAndFilter(),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//           Obx(() {
//             if (orderController.isLoading.value) {
//               return const SliverFillRemaining(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               );
//             }

//             final filteredOrders = _filterOrders(orderController.allOrders);

//             if (filteredOrders.isEmpty) {
//               return SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.shopping_bag_outlined,
//                         size: 80,
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'No orders found',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             return SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final order = filteredOrders[index];
//                   return _buildOrderCard(order, index);
//                 },
//                 childCount: filteredOrders.length,
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return SliverAppBar(
//       expandedHeight: 120,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         title: const Text(
//           'All Orders',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         background: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.8)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 bottom: -20,
//                 right: -20,
//                 child: Opacity(
//                   opacity: 0.1,
//                   child: Icon(
//                     Icons.shopping_bag,
//                     size: 200,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchAndFilter() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _searchController,
//             onChanged: (_) => setState(() {}),
//             decoration: InputDecoration(
//               hintText: 'Search by user or order ID',
//               prefixIcon: const Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               filled: true,
//               fillColor: Colors.grey[100],
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         DropdownButton<String>(
//           value: _selectedStatus,
//           items: _statusOptions.map((status) {
//             return DropdownMenuItem(
//               value: status,
//               child: Text(status.capitalize!),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               _selectedStatus = value!;
//             });
//           },
//           underline: const SizedBox(),
//           icon: const Icon(Icons.filter_list),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderCard(OrderModel order, int index) {
//     final animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500 + (index * 100)),
//     );
//     final slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: animationController,
//       curve: Curves.easeOutBack,
//     ));
//     final opacityAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: animationController,
//       curve: Curves.easeOut,
//     ));
//     animationController.forward();

//     return AnimatedBuilder(
//       animation: animationController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: slideAnimation.value * 50,
//           child: Opacity(
//             opacity: opacityAnimation.value,
//             child: child,
//           ),
//         );
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         elevation: 4,
//         child: ExpansionTile(
//           leading: CircleAvatar(
//             backgroundColor: _getStatusColor(order.status).withOpacity(0.2),
//             child: Icon(
//               _getStatusIcon(order.status),
//               color: _getStatusColor(order.status),
//             ),
//           ),
//           title: Text(
//             'Order #${order.id?.substring(0, 8).toUpperCase()}',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             '${DateFormat('MMM dd, yyyy').format(order.orderDate)} • PKR ${order.totalAmount.toInt()}',
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailRow('User', order.userName),
//                   _buildDetailRow('Email', order.userEmail),
//                   _buildDetailRow('Address', order.shippingAddress),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Products:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   ...order.products.map((product) => _buildProductRow(product)),
//                   const SizedBox(height: 16),
//                   _buildStatusUpdate(order),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[700],
//             ),
//           ),
//           Expanded(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductRow(CartItem product) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: CachedNetworkImage(
//           imageUrl: product.image,
//           width: 40,
//           height: 40,
//           fit: BoxFit.cover,
//           placeholder: (context, url) => const CircularProgressIndicator(),
//           errorWidget: (context, url, error) => const Icon(Icons.error),
//         ),
//       ),
//       title: Text(product.name),
//       subtitle: Text('Qty: ${product.quantity} • PKR ${product.price.toInt()}'),
//     );
//   }

//   Widget _buildStatusUpdate(OrderModel order) {
//     return DropdownButtonFormField<String>(
//       value: order.status,
//       decoration: InputDecoration(
//         labelText: 'Update Status',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       items: ['pending', 'shipped', 'delivered'].map((status) {
//         return DropdownMenuItem(
//           value: status,
//           child: Text(status.capitalize!),
//         );
//       }).toList(),
//       onChanged: (newStatus) {
//         if (newStatus != null) {
//           orderController.updateOrderStatus(order.id!, newStatus);
//         }
//       },
//     );
//   }

//   List<OrderModel> _filterOrders(List<OrderModel> orders) {
//     String query = _searchController.text.toLowerCase();
//     return orders.where((order) {
//       bool matchesStatus = _selectedStatus == 'All' || order.status == _selectedStatus;
//       bool matchesSearch = order.userName.toLowerCase().contains(query) ||
//           order.id!.toLowerCase().contains(query) ||
//           order.userEmail.toLowerCase().contains(query);
//       return matchesStatus && matchesSearch;
//     }).toList();
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'pending':
//         return Colors.orange;
//       case 'shipped':
//         return Colors.blue;
//       case 'delivered':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'pending':
//         return Icons.hourglass_bottom;
//       case 'shipped':
//         return Icons.local_shipping;
//       case 'delivered':
//         return Icons.check_circle;
//       default:
//         return Icons.info;
//     }
//   }
// }

// // Update OrderRepository.dart to add getAllOrders
// // Add this method to OrderRepository class:


// // Update OrderController.dart
// // Add RxList for allOrders and fetchAllOrders method


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/model/CartItem.dart';
import 'package:tryon/model/order_model.dart';
import 'package:tryon/view/admin_panel/order.dart';
import 'package:tryon/view_model/OrderController.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen>
    with TickerProviderStateMixin {
  late final OrderController orderController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // For search and filter
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  final List<String> _statusOptions = ['All', 'pending', 'shipped', 'delivered'];

  // Store animation controllers for each order card
  final Map<String, AnimationController> _orderAnimationControllers = {};

  @override
  void initState() {
    super.initState();
    orderController = Get.put(OrderController());
    orderController.fetchAllOrders();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _searchController.dispose();
    
    // Dispose all order animation controllers
    for (final controller in _orderAnimationControllers.values) {
      controller.dispose();
    }
    _orderAnimationControllers.clear();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchAndFilter(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Obx(() {
            if (orderController.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }

            final filteredOrders = _filterOrders(orderController.allOrders);

            if (filteredOrders.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No orders found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final order = filteredOrders[index];
                  return _buildOrderCard(order, index);
                },
                childCount: filteredOrders.length,
                addAutomaticKeepAlives: false, // Important for performance
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'All Orders',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -20,
                right: -20,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.shopping_bag,
                    size: 200,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search by user or order ID',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedStatus,
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.capitalize!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(OrderModel order, int index) {
    // Use order ID as key for the animation controller
    final orderId = order.id ?? 'order_$index';
    AnimationController? animationController;
    
    // Create animation controller if it doesn't exist
    if (!_orderAnimationControllers.containsKey(orderId)) {
      animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500 + (index * 100)),
      );
      _orderAnimationControllers[orderId] = animationController;
      // Start the animation when created
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && animationController != null) {
          animationController!.forward();
        }
      });
    } else {
      animationController = _orderAnimationControllers[orderId];
    }

    if (animationController == null) {
      // Fallback if animation controller creation failed
      return _buildStaticOrderCard(order);
    }

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    ));
    
    final opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    return AnimatedBuilder(
      animation: Listenable.merge([animationController, _fadeAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: slideAnimation.value * 50,
          child: Opacity(
            opacity: (opacityAnimation.value * _fadeAnimation.value).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: Card(
        key: ValueKey(orderId), // Ensure proper widget identity
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(order.status).withOpacity(0.2),
            child: Icon(
              _getStatusIcon(order.status),
              color: _getStatusColor(order.status),
            ),
          ),
          title: Text(
            'Order #${order.id?.substring(0, 8).toUpperCase()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${DateFormat('MMM dd, yyyy').format(order.orderDate)} • PKR ${order.totalAmount.toInt()}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User', order.userName),
                  _buildDetailRow('Email', order.userEmail),
                  _buildDetailRow('Address', order.shippingAddress),
                  const SizedBox(height: 16),
                  const Text(
                    'Products:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...order.products.map((product) => _buildProductRow(product)),
                  const SizedBox(height: 16),
                  _buildStatusUpdate(order),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fallback method for when animation controller can't be created
  Widget _buildStaticOrderCard(OrderModel order) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(order.status).withOpacity(0.2),
            child: Icon(
              _getStatusIcon(order.status),
              color: _getStatusColor(order.status),
            ),
          ),
          title: Text(
            'Order #${order.id?.substring(0, 8).toUpperCase()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${DateFormat('MMM dd, yyyy').format(order.orderDate)} • PKR ${order.totalAmount.toInt()}',
            style: TextStyle(color: Colors.grey[600]),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('User', order.userName),
                  _buildDetailRow('Email', order.userEmail),
                  _buildDetailRow('Address', order.shippingAddress),
                  const SizedBox(height: 16),
                  const Text(
                    'Products:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...order.products.map((product) => _buildProductRow(product)),
                  const SizedBox(height: 16),
                  _buildStatusUpdate(order),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(CartItem product) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: product.image,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image_not_supported, size: 20),
          ),
        ),
      ),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Qty: ${product.quantity} • PKR ${product.price.toInt()}',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildStatusUpdate(OrderModel order) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      child: DropdownButtonFormField<String>(
        value: order.status,
        decoration: InputDecoration(
          labelText: 'Update Status',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        items: ['pending', 'shipped', 'delivered'].map((status) {
          return DropdownMenuItem(
            value: status,
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(status),
                  color: _getStatusColor(status),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(status.capitalize!),
              ],
            ),
          );
        }).toList(),
        onChanged: (newStatus) {
          if (newStatus != null && newStatus != order.status) {
            orderController.updateOrderStatus(order.id!, newStatus);
          }
        },
      ),
    );
  }

  List<OrderModel> _filterOrders(List<OrderModel> orders) {
    String query = _searchController.text.toLowerCase();
    return orders.where((order) {
      bool matchesStatus = _selectedStatus == 'All' || order.status == _selectedStatus;
      bool matchesSearch = order.userName.toLowerCase().contains(query) ||
          (order.id?.toLowerCase().contains(query) ?? false) ||
          order.userEmail.toLowerCase().contains(query);
      return matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_bottom;
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }
}