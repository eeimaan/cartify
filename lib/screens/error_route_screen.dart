import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
          forceMaterialTransparency: true,
        centerTitle: true,
        backgroundColor: AppColors.colorWhite,
        elevation: 0,
        title: const Text(
          'Page not found',
          style: TextStyle(
            color: AppColors.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: AppFonts.medium,
          ),
        ),
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Image.asset(
          AppImage.pageNotFoundImg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
