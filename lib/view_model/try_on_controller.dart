import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryon/repository/auth_repo/auth_repository.dart';
import 'package:tryon/repository/product_repo/product_repo.dart';
import '../features/virtual_try_on/repositories/try_on_repository.dart';
import '../features/virtual_try_on/models/try_on_response.dart';

class TryOnController extends GetxController {
  final TryOnRepository _repository = TryOnRepository();
  final IProductRepository _iProductRepository;
  final IAuthRepository _authRepo = Get.find<IAuthRepository>();
var loadingStatus = 'Uploading image to database...'.obs;
  final CancelToken _cancelToken = CancelToken();

  // Observables
  final Rx<File?> actorImage = Rx<File?>(null);
  final Rx<File?> garmentImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<String?> resultUrl = Rx<String?>(null);
  final RxBool isUploadingActor = false.obs;
  final RxBool isUploadingGarment = false.obs;
  // final RxBool isLoading = false.obs; // true while generating result

  TryOnController({required IProductRepository iProductRepository})
    : _iProductRepository = iProductRepository; // Best approach

  // Computed property
  bool get canProcess => actorImage.value != null && garmentImage.value != null;

  // Image Picking Methods
  Future<void> pickActorImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
      if (pickedFile != null) {
        actorImage.value = File(pickedFile.path);
        error.value = '';
        resultUrl.value = null;
      }
    } catch (e) {
      error.value = 'Failed to pick image: ${e.toString()}';
    }
  }
  void cancelProcess() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('User cancelled the operation');
    }
    isLoading.value = false;
    loadingStatus.value = '';
  }
  Future<void> pickGarmentImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
      if (pickedFile != null) {
        garmentImage.value = File(pickedFile.path);
        error.value = '';
        resultUrl.value = null;
      }
    } catch (e) {
      error.value = 'Failed to pick image: ${e.toString()}';
    }
  }

  Future<void> processTryOn(String garmentImage) async {
  
    // if (!canProcess) return;

    isLoading.value = true;
    error.value = '';
      //  if (_cancelToken.isCancelled) return;
    try {
       loadingStatus = 'Uploading image to database...'.obs;

      final uid = DateTime.now().millisecondsSinceEpoch.toString();
      final actorBytes = actorImage.value!.readAsBytesSync();
      await _authRepo.signIn(email: "kk123@gmail.com", password: "111111");
      final actorUrl = await _iProductRepository.uploadImageToStorage(
        imageBytes: actorBytes,
        path: 'tryon/actors/$uid.jpg',
      );
loadingStatus.value = 'Processing your image...';
      final tryOnResponse = await _repository.tryOnShirtFromUrl(
        actorImageUrl: actorUrl,
        garmentImageUrl: garmentImage,
      );

      if (tryOnResponse.error != null) {
        error.value = tryOnResponse.error!;
        return;
      }

      final String requestId = tryOnResponse.id!;
      // Poll for completion
        loadingStatus.value = 'Generating try-on result...';
  // Generation code here
  
      while (true) {
        log("in while");
        await Future.delayed(const Duration(seconds: 3));
        final statusResponse = await _repository.getTryOnResult(requestId);

        if (statusResponse.error != null) {
          error.value = statusResponse.error!;
          break;
        }

        if (statusResponse.status == 'completed') {
          if (statusResponse.output.isNotEmpty) {
            resultUrl.value = statusResponse.output.first;
          } else {
            error.value = "No output image received.";
          }
          break;
        }
      }
    } catch (e) {
      error.value = 'Processing failed: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Reset everything
  void resetAll() {
    actorImage.value = null;
    garmentImage.value = null;
    resultUrl.value = null;
    error.value = '';
  }
}
