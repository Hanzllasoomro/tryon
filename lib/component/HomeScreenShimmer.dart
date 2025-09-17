import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
SizedBox(height: 39,),
            // Search Bar Placeholder
            _shimmerBox(width: size.width, height: 50, radius: 12),

            const SizedBox(height: 16),

            // Banner Placeholder
            _shimmerBox(width: size.width, height: 140, radius: 16),

            const SizedBox(height: 24),

            // Section Title
            _shimmerBox(width: 150, height: 20, radius: 8),

            const SizedBox(height: 16),

            // Best Selling Grid Placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(width: size.width * 0.42, height: 220, radius: 16),
                _shimmerBox(width: size.width * 0.42, height: 220, radius: 16),
              ],
            ),

            const SizedBox(height: 24),

            // Section Title
            _shimmerBox(width: 150, height: 20, radius: 8),

            const SizedBox(height: 16),

            // New Arrivals Horizontal Scroll Placeholder
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return _shimmerBox(
                    width: 120,
                    height: 150,
                    radius: 16,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 12,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
