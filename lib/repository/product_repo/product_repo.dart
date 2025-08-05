import 'dart:typed_data';

abstract class IProductRepository {
  Future<String> uploadImageToStorage({
    required Uint8List imageBytes,
    required String path,
  });
}
