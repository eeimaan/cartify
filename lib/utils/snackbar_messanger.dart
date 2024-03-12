import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.colorDarkBkue,
        content: Text(
          message,
          style: const TextStyle(color: AppColors.colorWhite),
        ),
      ),
    );
  }
}
