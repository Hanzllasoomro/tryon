import 'dart:developer';

import 'package:get/get.dart';
import 'package:tryon/constant/app_images.dart';
import 'package:tryon/model/UserModel.dart';
import 'package:tryon/repository/auth_repo/auth_repository.dart';
import 'package:tryon/view/navigation/admin_navigation.dart';
import 'package:tryon/view/navigation/navigation.dart';
import 'package:tryon/view_model/UserController.dart';

class AuthController extends GetxController {
  final IAuthRepository authRepo;
  final UserController userController = Get.put(UserController());

  var isLoading = false.obs;

  AuthController({required this.authRepo});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final uid = await authRepo.signUp(email: email, password: password);

      if (uid != null) {
        // create user model
        final newUser = UserModel(uid: uid, name: name, email: email);

        // update user state
        userController.setUser(newUser);

        Get.snackbar("Success", "Account created successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // ✅ Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final uid = await authRepo.signIn(email: email, password: password);

      if (uid != null) {
        // fetch user info from Firestore later if needed
        final user = UserModel(uid: uid, name: "", email: email);
        userController.setUser(user);
        log(user.email);
        if (user.email=="admin@gmail.com") {
log("in if");
Get.to(AdminNavigation());
        }else{
log("in else");
Get.to(Navigation());
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      final uid = await authRepo.signIn(email: email, password: password);

      if (uid != null) {
        // you might want to fetch user data from Firestore later
        final user = UserModel(uid: uid, name: "", email: email);
        userController.setUser(user);

        Get.snackbar("Success", "Logged in successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await authRepo.signOut();
    userController.clearUser();
    Get.snackbar("Success", "Logged out");
  }
}
