import 'dart:io';
import 'package:get/get.dart';
import 'package:tryon/model/product.dart';
import 'package:tryon/repository/product_repo/ProductRepository.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  var isLoading = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Upload product
  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    File? imageFile,
  }) async {
    try {
      isLoading.value = true;

      final String productId = const Uuid().v4();
      final product = Product(
        id: productId,
        name: name,
        description: description,
        price: price,
        imageUrl: "", // will update after upload
        createdAt: DateTime.now(),
      );

      await _repository.uploadProduct(product, imageFile: imageFile);

      products.add(product);
      Get.snackbar("Success", "Product uploaded successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }

 
  }
     Future<void> fetchProducts() async {
      try {
        isLoading.value = true;
        products.value = await _repository.fetchProducts();
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        isLoading.value = false;
      }
    }
}
