import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:google_fonts/google_fonts.dart';
import 'package:tryon/component/HomeScreenShimmer.dart';
import 'package:tryon/constant/app_colors.dart';
import 'package:tryon/model/products.dart';
import 'package:tryon/view/product/product_details.dart';
import 'package:tryon/view_model/CartController.dart';
import 'package:tryon/view_model/ProductController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void addToCart(String name, double price, String imagePath) {
    setState(() {
    });
  }

  int selectedindex = 0;
  PageController pageController = PageController();

  void ontap(int index) {
    setState(() {
      selectedindex = index;
    });

    pageController.jumpToPage(index);
  }

  final ProductController productController = Get.put(ProductController());
final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    return Obx(() {
      if (productController.isLoading.value) {
        return HomeScreenShimmer();
      }

      if (productController.products.isEmpty) {
        return const Center(child: Text("No products available"));
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // Ensure the whole content scrolls
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ), // Apply horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Add some spacing at the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/Group.png', width: 45, height: 45),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search Store',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // adjust radius as needed
                  child: Image.asset(
                    "assets/header.png",
                    width: screenWidth,
                    fit: BoxFit.cover, // keeps aspect ratio
                  ),
                ), // Make the banner width dynamic
                const SizedBox(height: 10),
             
                const SizedBox(height: 10),
               
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best Selling",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff53B175),
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        productController.products.map((product) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              child: ProductCard(
                                imageUrl: product.imageUrl,
                                name: product.name,
                                price: "${product.price}",
                                weight: '',
                                priceValue: product.price,
                              ),
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsScreen(
                                          productName: product.name,
                                          productPrice: product.price,
                                          productDescription:
                                              product.description,
                                          productImage: product.imageUrl,
                                          productRating: 2,
                                        );
                                      },
                                    ),
                                  ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivals",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff53B175),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 248,
                          height: 105,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 150, 130),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xffF7A593),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/cargo.png'),
                              const SizedBox(width: 10),
                              Text(
                                'Cargo',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 248,
                          height: 105,
                          decoration: BoxDecoration(
                            color: const Color(0xffF8A44C),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xffF8A44C),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/T-shirt.png'),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'T-Shirts',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
            
              ],
            ),
          ),
        ),
      );
    });
  }
}
