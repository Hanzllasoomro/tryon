import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view/navigation/navigation.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.elasticOut),
      ),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
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
          return Stack(
            children: [
              // Background with gradient
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF4F7FB),
                      Color(0xFFE8F0F8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated checkmark icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: 100,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Title
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
                      )),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "Your Order has been accepted",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Description
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
                      )),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "Your items has been placed and is on it's way to being processed",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Track Order Button
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                      )),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                                  return Navigation();
                                }));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Back to home",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // // Back to Home Button
                    // SlideTransition(
                    //   position: Tween<Offset>(
                    //     begin: const Offset(0, 0.5),
                    //     end: Offset.zero,
                    //   ).animate(CurvedAnimation(
                    //     parent: _animationController,
                    //     curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
                    //   )),
                    //   child: FadeTransition(
                    //     opacity: _fadeAnimation,
                    //     child: SizedBox(
                    //       width: double.infinity,
                    //       child: OutlinedButton(
                    //         onPressed: () {
                    //           // Navigator.pop(context);
                            
                    //               },
                    //         style: OutlinedButton.styleFrom(
                    //           foregroundColor: AppColors.primaryColor,
                    //           padding: const EdgeInsets.symmetric(vertical: 16),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(16),
                    //           ),
                    //           side: BorderSide(color: AppColors.primaryColor),
                    //         ),
                    //         child: const Text(
                    //           "Back to home",
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              
              // Decorative elements
              Positioned(
                top: 50,
                right: 20,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 100,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 20,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.local_shipping_outlined,
                    size: 80,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}