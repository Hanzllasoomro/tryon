import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryon/model/product.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadProduct(Product product, {File? imageFile}) async {
    try {
      String imageUrl = product.imageUrl;

      // If a new image is provided, upload it to Firebase Storage
      if (imageFile != null) {
        final ref = _storage.ref().child("products/${product.id}.jpg");
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
      }

      // Save product data to Firestore
      await _firestore
          .collection("products")
          .doc(product.id)
          .set(product.copyWith(imageUrl: imageUrl).toMap());
    } catch (e) {
      throw Exception("Failed to upload product: $e");
    }
  }


  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("products").get();
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }
}
