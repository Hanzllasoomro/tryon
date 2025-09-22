import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/constant/app_images.dart';
import 'package:tryon/view/auth/login.dart';
import 'package:tryon/view/navigation/admin_navigation.dart';
import 'package:tryon/view/navigation/navigation.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Set up animations
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Start the animation
    _controller.forward();

  // Delay for splash screen
  Future.delayed(const Duration(seconds: 3), () {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in -> navigate to Dashboard
  if (user.email=="admin@gmail.com") {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminNavigation()),
      );
  } else {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
  }
    } else {
      // User not logged in -> navigate to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              top: -50,
              right: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: -40,
              left: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.yellow.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App logo with decorative container
                      Image.asset(AppImages.appIcon,height: 250,width: 250,),

                      // const SizedBox(height: 30),

                      // App name with stylish text
                      // ShaderMask(
                      //   blendMode: BlendMode.srcIn,
                      //   shaderCallback:
                      //       (bounds) => const LinearGradient(
                      //         colors: [
                      //           AppColors.primaryColor,
                      //           AppColors.primaryColor,
                      //         ],
                      //       ).createShader(bounds),
                      //   child: const Text(
                      //     "TryNBuy", // Replace with your app name
                      //     style: TextStyle(
                      //       fontSize: 32,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 1.5,
                      //     ),
                      //   ),
                      // ),

                      // const SizedBox(height: 10),

                      // Tagline
                      Text(
                        "Bringing the fitting room to your phone", // Replace with your tagline
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Loading indicator at the bottom
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Loading...",
                    style: TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
