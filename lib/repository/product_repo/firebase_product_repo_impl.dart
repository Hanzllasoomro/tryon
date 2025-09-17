import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tryon/repository/product_repo/product_repo.dart';
class FirebaseProductRepoImpl extends IProductRepository {
  static final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



@override
Future<String> uploadImageToStorage({
  required Uint8List imageBytes,
  required String path,
}) async {
  try {
    final ref = _storageReference.child(path);
    final uploadTask = await ref.putData(imageBytes);
    if (uploadTask.state == TaskState.success) {
      return await ref.getDownloadURL();
    } else {
      throw Exception("Upload failed: ${uploadTask.state}");
    }
  } catch (e) {
    throw Exception("Image upload failed: $e");
  }
}

}
