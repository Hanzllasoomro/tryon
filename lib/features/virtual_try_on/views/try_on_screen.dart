
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryon/component/loading_dialogue.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/repository/product_repo/product_repo.dart';
import '../../../view_model/try_on_controller.dart';

class TryOnScreen extends StatelessWidget {
  final String garmentImage;
  TryOnScreen({Key? key, required this.garmentImage }) : super(key: key);
  final TryOnController _controller = Get.put(
    TryOnController(iProductRepository: Get.find<IProductRepository>()),
  );

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Virtual Try-On',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _controller.resetAll,
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background elements
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
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  // Header section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFF3E9), Color(0xFFFFE5D3)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Style Your Look Instantly',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload your photo and see how our clothes look on you',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Try It Now',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Image upload section
                  Text(
                    'Upload Your Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Obx(() {
                    return GestureDetector(
                      onTap: _controller.pickActorImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _controller.actorImage.value != null
                                ? AppColors.primaryColor
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: _controller.isUploadingActor.value
                            ? const Center(child: CircularProgressIndicator())
                            : _controller.actorImage.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _controller.actorImage.value!,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 48,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Tap to upload your photo',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 24),
                  
                  // Try-On Button
                  Obx(() {
                    return ElevatedButton(
                      // onPressed: _controller.canProcess && !_controller.isLoading.value
                      //     ? ()=>_controller.processTryOn(garmentImage)
                      //     : null,
                      onPressed: () => _controller.processTryOn(garmentImage),
 

                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.white,
                        disabledBackgroundColor: Colors.grey[300],
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'GENERATE TRY-ON',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    );
                  }),
                  
                  const SizedBox(height: 20),
             
                  Obx(() {
  if (_controller.resultUrl.value != null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Try-On Result',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              _controller.resultUrl.value!,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Failed to load image',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  } else {
    return const SizedBox.shrink(); // empty if no result
  }
}),

                  const SizedBox(height: 30),
                  
             
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Obx(() {
  if (_controller.isLoading.value) {
    return TryOnLoadingDialog(
      onCancel: () {
        _controller.isLoading.value=false;
              _controller.cancelProcess();

        Navigator.pop(context);
      },
      statusMessage: _controller.loadingStatus,
    );
  }
  return const SizedBox.shrink();
})  ],
      ),
    );

  }
}