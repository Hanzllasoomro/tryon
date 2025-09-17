import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tryon/constant/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double heightFactor;
  final double widthFactor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.heightFactor = 0.07,
    this.widthFactor = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      width: MediaQuery.of(context).size.width * widthFactor,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: TextButton(
        onPressed: isLoading ? null : onPressed, // disable when loading
        child:
            isLoading
                ? const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  
                )
                : Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: const Color(0xffFFF9FF),
                  ),
                ),
      ),
    );
  }
}
