import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tryon/constant/app_colors.dart';

// class LoadingDialog {
//   static void show({String message = "Loading..."}) {
//     Get.dialog(
//       WillPopScope(
//         onWillPop: () async => false, // prevent back button dismiss
//         child: Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Lottie.asset(
//                   'assets/animations/loading.json', // your Lottie file
//                   width: 120,
//                   height: 120,
//                   repeat: true,
//                 ),
//                 const SizedBox(height: 16),
//                 Obx(() => Text(
//                       _loadingMessage.value,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   static void hide() {
//     if (Get.isDialogOpen ?? false) {
//       Get.back();
//     }
//   }

//   // observable message for dynamic updates
//   static final RxString _loadingMessage = "Loading...".obs;

//   static void updateMessage(String message) {
//     _loadingMessage.value = message;
//   }
// }


// Loading Dialog with Lottie Animation
class TryOnLoadingDialog extends StatelessWidget {
  final RxString statusMessage;
  VoidCallback onCancel;
   TryOnLoadingDialog({required this.statusMessage, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie Animation
            SizedBox(
              height: 150,
              child: Lottie.asset(
                'assets/loading.json', // Replace with your Lottie file path
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Progress Text
          Obx(()=> Text(
              statusMessage.value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),),
            
            const SizedBox(height: 16),
            
            // Progress Indicator
            const SizedBox(
              height: 4,
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Optional: Cancel button
            TextButton(
              onPressed:onCancel,
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}