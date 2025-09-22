
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view/order/user_orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Start animation after build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: child,
            ),
          );
        },
        child: CustomScrollView(
          slivers: [
            // Header with user info
            SliverAppBar(
              expandedHeight: 220,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.yellow],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative elements
                      Positioned(
                        top: 30,
                        right: 20,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.person_outline, 
                              size: 150, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const CircleAvatar(
                            //   radius: 40,
                            //   backgroundColor: Colors.white,
                            //   child: CircleAvatar(
                            //     radius: 36,
                            //     backgroundImage: NetworkImage(
                            //         'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80'),
                            //   ),
                            // ),
                            const SizedBox(height: 16),
                            Text(
                            FirebaseAuth.instance.currentUser!.email!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Text(
                            //   'Nitishr833@gmail.com',
                            //   style: TextStyle(
                            //     color: Colors.white.withOpacity(0.9),
                            //     fontSize: 14,
                            //     shadows: [
                            //       Shadow(
                            //         blurRadius: 4,
                            //         color: Colors.black.withOpacity(0.2),
                            //         offset: const Offset(1, 1),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Profile options
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),
                
                // Quick actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: _buildActionButton(
                          icon: Icons.shopping_bag_outlined,
                          label: 'Orders',
                          color: AppColors.primaryColor,
                        ),
                        onTap: () => Get.to(OrdersScreen(userId: FirebaseAuth.instance.currentUser!.uid)),
                      ),
                      _buildActionButton(
                        icon: Icons.payment_outlined,
                        label: 'Payments',
                        color: AppColors.yellow,
                      ),
                      _buildActionButton(
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        color: AppColors.mediumPink,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // User details section
                _buildSectionHeader('User Details'),
                _buildOptionTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  color: AppColors.primaryColor,
                ),
                _buildOptionTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  color: AppColors.yellow,
                ),
                _buildOptionTile(
                  icon: Icons.language_outlined,
                  title: 'Change Language',
                  color: AppColors.mediumPink,
                ),
                
                const SizedBox(height: 16),
                
                // Logout button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Handle logout
                      },
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.red.withOpacity(0.2),
                      highlightColor: Colors.red.withOpacity(0.1),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            const SizedBox(width: 16),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.chevron_right, color: Colors.red.withOpacity(0.5)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.grey.withOpacity(0.7),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle option tap
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: color.withOpacity(0.2),
          highlightColor: color.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, 
                    color: Colors.grey.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}