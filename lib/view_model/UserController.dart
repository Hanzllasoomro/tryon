import 'package:get/get.dart';
import 'package:tryon/model/UserModel.dart';

class UserController extends GetxController {
  var currentUser = Rxn<UserModel>();

  void setUser(UserModel? user) {
    currentUser.value = user;
  }

  void clearUser() {
    currentUser.value = null;
  }
}
