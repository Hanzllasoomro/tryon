// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tryon/component/PrimaryButton.dart';
// import 'dart:io';

// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/view_model/ProductController.dart';

// class UploadProductScreen extends StatefulWidget {
//   const UploadProductScreen({super.key});

//   @override
//   State<UploadProductScreen> createState() => _UploadProductScreenState();
// }

// class _UploadProductScreenState extends State<UploadProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final ProductController controller = Get.put(ProductController());

//   File? _productImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _getImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _productImage = File(image.path);
//       });
//     }
//   }

//   void _submitForm() async{
//     if (_formKey.currentState!.validate() && _productImage != null) {
//       // Process data - in a real app, you would upload to your backend
//    await   controller.addProduct(
//         name: _nameController.text,
//         description: _descriptionController.text,
//         price: double.parse(_priceController.text),
//         imageFile: _productImage, // optional
//       );
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     backgroundColor: AppColors.primaryColor,
//       //     content: const Text('Product uploaded successfully!'),
//       //   ),
//       // );
//       // Navigator.pop(context);
//     } else if (_productImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Please select an image for your product'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back,
//                         color: AppColors.black,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       'Upload Product',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image Upload Section
//                       Center(
//                         child: GestureDetector(
//                           onTap: _getImage,
//                           child: Container(
//                             width: 150,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: AppColors.primaryColor,
//                                 width: 2,
//                               ),
//                             ),
//                             child:
//                                 _productImage == null
//                                     ? Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: const [
//                                         Icon(
//                                           Icons.add_photo_alternate,
//                                           size: 40,
//                                           color: AppColors.grey,
//                                         ),
//                                         SizedBox(height: 10),
//                                         Text(
//                                           'Add Image',
//                                           style: TextStyle(
//                                             color: AppColors.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                     : ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Image.file(
//                                         _productImage!,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),

//                       // Product Name Field
//                       const Text(
//                         'Product Name',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Enter product name',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a product name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),

//                       // Price Field
//                       const Text(
//                         'Price',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _priceController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Enter price',
//                           prefixIcon: const Icon(
//                             Icons.attach_money,
//                             color: AppColors.grey,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a price';
//                           }
//                           if (double.tryParse(value) == null) {
//                             return 'Please enter a valid price';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),

//                       // Description Field
//                       const Text(
//                         'Description',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _descriptionController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Enter product description',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a description';
//                           }
//                           if (value.length < 10) {
//                             return 'Description should be at least 10 characters long';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 30),

//                       Obx(
//                         () => PrimaryButton(
//                           text: 'Upload Product',
//                           isLoading: controller.isLoading.value,
//                           onPressed: _submitForm,
//                         ),
//                       ),
//                       // Upload Button
//                       // SizedBox(
//                       //   width: double.infinity,
//                       //   child: ElevatedButton(
//                       //     onPressed: _submitForm,
//                       //     style: ElevatedButton.styleFrom(
//                       //       backgroundColor: AppColors.primaryColor,
//                       //       padding: const EdgeInsets.symmetric(vertical: 16),
//                       //       shape: RoundedRectangleBorder(
//                       //         borderRadius: BorderRadius.circular(10),
//                       //       ),
//                       //       elevation: 3,
//                       //     ),
//                       //     child: const Text(
//                       //       'Upload Product',
//                       //       style: TextStyle(
//                       //         fontSize: 18,
//                       //         fontWeight: FontWeight.bold,
//                       //         color: Colors.black,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:tryon/component/PrimaryButton.dart';
// import 'package:tryon/constant/app_colors.dart';
// import 'package:tryon/view_model/ProductController.dart';

// class UploadProductScreen extends StatefulWidget {
//   const UploadProductScreen({super.key});

//   @override
//   State<UploadProductScreen> createState() => _UploadProductScreenState();
// }

// class _UploadProductScreenState extends State<UploadProductScreen>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final ProductController controller = Get.put(ProductController());

//   File? _productImage;
//   final ImagePicker _picker = ImagePicker();

//   // Animation controllers
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late AnimationController _scaleController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _scaleAnimation;

//   // Form step tracking
//   int _currentStep = 0;
//   final int _totalSteps = 3;

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize animations
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOutBack,
//     ));
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );

//     // Start animations
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _fadeController.forward();
//       _slideController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     _scaleController.dispose();
//     _nameController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _getImage() async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1200,
//       maxHeight: 1200,
//       imageQuality: 85,
//     );
//     if (image != null) {
//       setState(() {
//         _productImage = File(image.path);
//       });
//       _scaleController.forward().then((_) => _scaleController.reverse());
//     }
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate() && _productImage != null) {
//       // Show loading animation
//       _scaleController.forward();
      
//       try {
//         await controller.addProduct(
//           name: _nameController.text.trim(),
//           description: _descriptionController.text.trim(),
//           price: double.parse(_priceController.text.trim()),
//           imageFile: _productImage,
//         );
        
//         // Success animation
//         _showSuccessAnimation();
//       } catch (e) {
//         Get.snackbar(
//           'Upload Failed',
//           'Something went wrong: $e',
//           backgroundColor: Colors.red.withOpacity(0.1),
//           colorText: Colors.red,
//           snackPosition: SnackPosition.TOP,
//           duration: const Duration(seconds: 3),
//         );
//       } finally {
//         _scaleController.reverse();
//       }
//     } else if (_productImage == null) {
//       _showImageError();
//     }
//   }

//   void _showSuccessAnimation() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => SuccessDialog(
//         onComplete: () {
//           Navigator.pop(context);
//           Navigator.pop(context); // Go back to previous screen
//         },
//       ),
//     );
//   }

//   void _showImageError() {
//     Get.snackbar(
//       'Image Required',
//       'Please select a product image to continue',
//       backgroundColor: Colors.orange.withOpacity(0.1),
//       colorText: Colors.orange[800],
//       snackPosition: SnackPosition.TOP,
//       icon: const Icon(Icons.image_not_supported, color: Colors.orange),
//       duration: const Duration(seconds: 2),
//     );
//   }

//   void _nextStep() {
//     if (_currentStep < _totalSteps - 1) {
//       setState(() => _currentStep++);
//       _slideController.forward().then((_) => _slideController.reverse());
//     }
//   }

//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() => _currentStep--);
//       _slideController.reverse().then((_) => _slideController.forward());
//     }
//   }

//   Widget _buildStepIndicator() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 16), // Reduced vertical margin
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(_totalSteps, (index) {
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: const EdgeInsets.symmetric(horizontal: 6),
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _currentStep == index 
//                   ? AppColors.primaryColor 
//                   : Colors.grey.withOpacity(0.3),
//               boxShadow: _currentStep == index
//                   ? [
//                       BoxShadow(
//                         color: AppColors.primaryColor.withOpacity(0.3),
//                         blurRadius: 6,
//                         spreadRadius: 1,
//                       )
//                     ]
//                   : null,
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildImageUploadSection() {
//     return Column(
//       children: [
//         // Image Upload Container
//         AnimatedBuilder(
//           animation: _scaleAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _scaleAnimation.value,
//               child: GestureDetector(
//                 onTap: _getImage,
//                 child: Container(
//                   width: 140, // Reduced size for better proportions
//                   height: 140,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white,
//                         Colors.white.withOpacity(0.95),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       width: 2,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 15,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       if (_productImage == null) ...[
//                         const Positioned.fill(
//                           child: Icon(
//                             Icons.add_photo_alternate_outlined,
//                             size: 40,
//                             color: AppColors.primaryColor,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: -8,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: const Text(
//                               'Upload Image',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ] else ...[
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(14),
//                           child: Image.file(
//                             _productImage!,
//                             width: 140,
//                             height: 140,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: -4,
//                           right: -4,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() => _productImage = null);
//                               _scaleController.reverse();
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.close,
//                                 color: Colors.red,
//                                 size: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: -8,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 6,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.9),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(Icons.check_circle, 
//                                     color: Colors.green, size: 14),
//                                 const SizedBox(width: 4),
//                                 const Text(
//                                   'Selected',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         const SizedBox(height: 16), // Reduced spacing
//         Text(
//           _productImage == null 
//               ? 'Tap to upload your product image' 
//               : 'Great! Your product image is ready',
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 13,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildFormField({
//     required String label,
//     required TextEditingController controller,
//     required String hintText,
//     IconData? icon,
//     TextInputType? keyboardType,
//     int? maxLines,
//     String? Function(String?)? validator,
//     bool obscureText = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20), // Consistent spacing
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   icon ?? Icons.text_fields,
//                   color: AppColors.primaryColor,
//                   size: 18,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             maxLines: maxLines ?? 1,
//             obscureText: obscureText,
//             validator: validator,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(color: Colors.grey[400]),
//               filled: true,
//               fillColor: Colors.white,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 16,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.grey[200]!),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(color: Colors.grey[200]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide(
//                   color: AppColors.primaryColor,
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
    
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               AppColors.primaryColor.withOpacity(0.03), // Reduced opacity
//               Colors.white,
//               Colors.grey.withOpacity(0.01),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.width * 0.06, // Slightly more padding
//                 vertical: 16, // Reduced top padding
//               ),
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header - Reduced spacing
//                     Row(
//                       children: [
//                         Hero(
//                           tag: 'back_button',
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(12),
//                               onTap: () => Navigator.pop(context),
//                               child: Container(
//                                 padding: const EdgeInsets.all(10), // Reduced padding
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: const Icon(
//                                   Icons.arrow_back_ios_new,
//                                   color: AppColors.primaryColor,
//                                   size: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12), // Reduced spacing
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Create New',
//                                 style: TextStyle(
//                                   fontSize: 14, // Reduced font size
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               const Text(
//                                 'Product',
//                                 style: TextStyle(
//                                   fontSize: 24, // Reduced from 28
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20), // Reduced from 30

//                     // Step Indicator - Reduced spacing
//                     _buildStepIndicator(),
//                     const SizedBox(height: 24), // Reduced from 30

//                     // Dynamic Content Based on Step
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 400),
//                       child: _buildCurrentStepContent(),
//                       transitionBuilder: (child, animation) {
//                         return SlideTransition(
//                           position: Tween<Offset>(
//                             begin: const Offset(0, 0.1), // Reduced slide distance
//                             end: Offset.zero,
//                           ).animate(animation),
//                           child: FadeTransition(opacity: animation, child: child),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 24), // Reduced from 40

//                     // Navigation Buttons - Only show when needed
//                     if (_currentStep < _totalSteps - 1) // Hide on final step
//                       _buildNavigationButtons(),
//                     const SizedBox(height: 24), // Reduced from 30

//                     // Upload Button - FIXED GetX ISSUE
//                     AnimatedBuilder(
//                       animation: _scaleAnimation,
//                       builder: (context, child) {
//                         return Transform.scale(
//                           scale: _scaleAnimation.value,
//                           child: controller.isLoading.value 
//                               ?  PrimaryButton(
//                                   text: 'Uploading...',
//                                   isLoading: true,
//                                   onPressed: (){}, // Disable when loading
//                                 )
//                               : PrimaryButton(
//                                   text: 'Upload Product',
//                                   isLoading: false,
//                                   onPressed: _submitForm,
//                                 ),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 20), // Small bottom padding
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCurrentStepContent() {
//     switch (_currentStep) {
//       case 0:
//         return _buildImageUploadSection();
//       case 1:
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add small horizontal padding
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildFormField(
//                   label: 'Product Name',
//                   controller: _nameController,
//                   hintText: 'What should we call your amazing product?',
//                   icon: Icons.inventory_2_outlined,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Product name is required';
//                     }
//                     if (value.trim().length < 3) {
//                       return 'Name should be at least 3 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 _buildFormField(
//                   label: 'Price',
//                   controller: _priceController,
//                   hintText: 'How much does it cost?',
//                   icon: Icons.attach_money,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Price is required';
//                     }
//                     final price = double.tryParse(value.trim());
//                     if (price == null || price <= 0) {
//                       return 'Please enter a valid price';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       case 2:
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add small horizontal padding
//           child: _buildFormField(
//             label: 'Product Description',
//             controller: _descriptionController,
//             hintText: 'Tell us more about your product... What makes it special?',
//             icon: Icons.description_outlined,
//             maxLines: 6,
//             validator: (value) {
//               if (value == null || value.trim().isEmpty) {
//                 return 'Description is required';
//               }
//               if (value.trim().length < 20) {
//                 return 'Description should be at least 20 characters long';
//               }
//               return null;
//             },
//           ),
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   Widget _buildNavigationButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add small horizontal padding
//       child: Row(
//         children: [
//           if (_currentStep > 0)
//             Expanded(
//               child: TextButton.icon(
//                 onPressed: _previousStep,
//                 icon: const Icon(Icons.arrow_back_ios, size: 16),
//                 label: const Text('Previous'),
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//           if (_currentStep > 0) const SizedBox(width: 16),
//           Expanded(
//             flex: _currentStep == 0 ? 2 : 1,
//             child: ElevatedButton.icon(
//               onPressed: _nextStep,
//               icon: const Icon(Icons.arrow_forward_ios, size: 16),
//               label: const Text('Next'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Success Dialog Widget
// class SuccessDialog extends StatefulWidget {
//   final VoidCallback onComplete;

//   const SuccessDialog({super.key, required this.onComplete});

//   @override
//   State<SuccessDialog> createState() => _SuccessDialogState();
// }

// class _SuccessDialogState extends State<SuccessDialog>
//     with TickerProviderStateMixin {
//   late AnimationController _successController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _successController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
    
//     _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _successController,
//         curve: Curves.elasticOut,
//       ),
//     );
//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _successController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _successController.forward();
    
//     // Auto dismiss after 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         widget.onComplete();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _successController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(40),
//       child: AnimatedBuilder(
//         animation: _successController,
//         builder: (context, child) {
//           return Transform.scale(
//             scale: _scaleAnimation.value,
//             child: Opacity(
//               opacity: _opacityAnimation.value,
//               child: Container(
//                 padding: const EdgeInsets.all(24), // Reduced padding
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 64, // Reduced size
//                       height: 64,
//                       decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 40,
//                       ),
//                     ),
//                     const SizedBox(height: 16), // Reduced spacing
//                     const Text(
//                       'Product Uploaded!',
//                       style: TextStyle(
//                         fontSize: 20, // Reduced from 24
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Your product is now live and ready for customers!',
//                       style: TextStyle(
//                         fontSize: 14, // Reduced from 16
//                         color: Colors.grey[600],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16), // Reduced from 24
//                     LinearProgressIndicator(
//                       value: 1.0,
//                       backgroundColor: Colors.grey[300],
//                       valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//                       minHeight: 4,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryon/component/PrimaryButton.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/view_model/ProductController.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ProductController controller = Get.put(ProductController());

  File? _productImage;
  final ImagePicker _picker = ImagePicker();
  
  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  // Form focus nodes
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  
  // Current active step for stepper UI
  int _currentStep = 0;
  
  // Image upload method
bool _isPickingImage = false;

Future<void> _getImage() async {
  if (_isPickingImage) return; // Prevent multiple calls
  
  _isPickingImage = true;
  
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _productImage = File(image.path);
        if (_currentStep == 0) _currentStep = 1;
      });
      
      // Animate to next section after image selection
      if (_nameFocus.hasFocus) _nameFocus.unfocus();
      if (_priceFocus.hasFocus) _priceFocus.unfocus();
      if (_descriptionFocus.hasFocus) _descriptionFocus.unfocus();
      
      Future.delayed(const Duration(milliseconds: 300), () {
        Scrollable.ensureVisible(
          _formKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  } catch (e) {
    // Handle any errors that might occur
    if (kDebugMode) {
      print('Image picker error: $e');
    }
  } finally {
    _isPickingImage = false; // Reset flag
  }
}

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _animationController.forward();
    
    // Add listeners to focus nodes for better UX
    _nameFocus.addListener(() {
      if (_nameFocus.hasFocus && _currentStep < 1) _currentStep = 1;
    });
    
    _priceFocus.addListener(() {
      if (_priceFocus.hasFocus && _currentStep < 2) _currentStep = 2;
    });
    
    _descriptionFocus.addListener(() {
      if (_descriptionFocus.hasFocus && _currentStep < 3) _currentStep = 3;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _nameFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _productImage != null) {
      await controller.addProduct(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageFile: _productImage,
      );
    } else if (_productImage == null) {
      // Shake animation for image upload section when missing
      _animationController.forward(from: 0.0).then((_) {
        _animationController.repeat(reverse: true, period: const Duration(milliseconds: 100));
        Future.delayed(const Duration(milliseconds: 500), () => _animationController.stop());
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const Text('Please select an image for your product'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with smooth entrance
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: AppColors.black,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Upload Product',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Progress indicator
                    _buildProgressStepper(),
                    const SizedBox(height: 20),
                    
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image Upload Section with enhanced design
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Transform.translate(
                              offset: Offset(0, _slideAnimation.value),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Product Image',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  GestureDetector(
                                    onTap: _getImage,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      width: double.infinity,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: _productImage == null 
                                            ? AppColors.primaryColor.withOpacity(0.5) 
                                            : AppColors.primaryColor,
                                          width: _productImage == null ? 1.5 : 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: _productImage == null
                                          ? Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.cloud_upload_outlined,
                                                  size: 50,
                                                  color: AppColors.primaryColor.withOpacity(0.7),
                                                ),
                                                const SizedBox(height: 12),
                                                Text(
                                                  'Tap to upload product image',
                                                  style: TextStyle(
                                                    color: AppColors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  'JPG, PNG up to 5MB',
                                                  style: TextStyle(
                                                    color: AppColors.grey.withOpacity(0.7),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Stack(
                                                children: [
                                                  Image.file(
                                                    _productImage!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ),
                                                  Positioned(
                                                    bottom: 10,
                                                    right: 10,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.6),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Product Name Field with enhanced design
                          _buildFormField(
                            label: 'Product Name',
                            hint: 'Enter product name',
                            controller: _nameController,
                            focusNode: _nameFocus,
                            icon: Icons.shopping_bag_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a product name';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_priceFocus);
                            },
                          ),
                          const SizedBox(height: 20),

                          // Price Field with enhanced design
                          _buildFormField(
                            label: 'Price',
                            hint: 'Enter price',
                            controller: _priceController,
                            focusNode: _priceFocus,
                            icon: Icons.price_change,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid price';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_descriptionFocus);
                            },
                          ),
                          const SizedBox(height: 20),

                          // Description Field with enhanced design
                          _buildFormField(
                            label: 'Description',
                            hint: 'Tell us about your product...',
                            controller: _descriptionController,
                            focusNode: _descriptionFocus,
                            icon: Icons.description_outlined,
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              if (value.length < 10) {
                                return 'Description should be at least 10 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),

                          // Upload Button with enhanced design
                          Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                              transform: Matrix4.translationValues(
                                0, 
                                controller.isLoading.value ? 10 : 0, 
                                0
                              ),
                              child: PrimaryButton(
                                text: 'Upload Product',
                                isLoading: controller.isLoading.value,
                                onPressed: _submitForm,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryColor,
                                    AppColors.primaryColor.withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Custom form field builder for consistent styling
  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    void Function(String)? onFieldSubmitted,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Transform.translate(
        offset: Offset(0, _slideAnimation.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
                maxLines: maxLines,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: validator,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Progress stepper indicator
  Widget _buildProgressStepper() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Transform.translate(
        offset: Offset(0, _slideAnimation.value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStep(1, 'Image', _currentStep >= 0),
            _buildStep(2, 'Details', _currentStep >= 1),
            _buildStep(3, 'Review', _currentStep >= 2),
          ],
        ),
      ),
    );
  }

  // Individual step widget
  Widget _buildStep(int stepNumber, String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text('$stepNumber', style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    )),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primaryColor : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}