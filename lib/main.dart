import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryon/admin_splash.dart';
import 'package:tryon/firebase_options.dart';
import 'package:tryon/repository/auth_repo/auth_repository.dart';
import 'package:tryon/repository/auth_repo/firebase_auth_repository.dart';
import 'package:tryon/repository/product_repo/firebase_product_repo_impl.dart';
import 'package:tryon/repository/product_repo/product_repo.dart';
import 'package:tryon/view/admin_panel/order.dart';
import 'package:tryon/view/auth/login.dart';
import 'package:tryon/view/navigation/admin_navigation.dart';
import 'package:tryon/view/navigation/navigation.dart';
import 'package:tryon/view/product/UploadProductScreen.dart';
import 'package:tryon/view/splash.dart';
// import 'package:tryon/firebase_options.dart';

Future<void> main() async {
  // await dotenv.load(fileName: '.env'); // Load environment variables
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    

  );

  servicesLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetX's MaterialApp
      title: 'Virtual Try-On App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      home:  AdminSplash(), // Directly load your feature screen
    );
  
  }


}

void servicesLocator() {
  // Register AuthRepository with FirebaseAuthRepository
  Get.lazyPut<IProductRepository>(() => FirebaseProductRepoImpl());
    Get.lazyPut<IAuthRepository>(() => FirebaseAuthRepository());

}
