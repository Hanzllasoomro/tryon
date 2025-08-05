
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryon/repository/product_repo/product_repo.dart';
import '../../../view_model/try_on_controller.dart';

class TryOnScreen extends StatelessWidget {
  TryOnScreen({Key? key}) : super(key: key);
  final TryOnController _controller = Get.put(
    TryOnController(iProductRepository: Get.find<IProductRepository>()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Try-On'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _controller.resetAll,
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildImageSelectionCard(
                        title: 'Actor Photo',
                        image: _controller.actorImage.value,
                        isUploading: _controller.isUploadingActor.value,
                        onPressed: _controller.pickActorImage,
                      ),
                      _buildImageSelectionCard(
                        title: 'Garment Image',
                        image: _controller.garmentImage.value,
                        isUploading: _controller.isUploadingGarment.value,
                        onPressed: _controller.pickGarmentImage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Try-On Button
                  ElevatedButton(
                    onPressed: _controller.canProcess && !_controller.isLoading.value
                        ? _controller.processTryOn
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      disabledBackgroundColor: Colors.grey[400],
                    ),
                    child: const Text(
                      'GENERATE TRY-ON',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Error message
                  if (_controller.error.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _controller.error.value,
                        style: TextStyle(color: Colors.red[700], fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Result
                  if (_controller.resultUrl.value != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const Text(
                              'Try-On Result',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    _controller.resultUrl.value!,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : const Center(child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error, color: Colors.red),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),

          // Global Loading Overlay
          Obx(() {
            if (_controller.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildImageSelectionCard({
    required String title,
    required File? image,
    required bool isUploading,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isUploading
                      ? const Center(child: CircularProgressIndicator())
                      : image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.add_photo_alternate,
                              size: 48,
                              color: Colors.grey,
                            ),
                ),
                const SizedBox(height: 8),
                Text(
                  image != null ? 'Tap to change' : 'Tap to select',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
