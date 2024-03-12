import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import '../constants/constants.dart';

class CustomUserInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const CustomUserInfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.labelStyle = const TextStyle(fontSize: AppFonts.medium),
    this.valueStyle =
        const TextStyle(fontSize: AppFonts.medium, color: AppColors.colorDarkBkue),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: labelStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCartCalulation extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final double valueSize;
  const CustomCartCalulation({
    Key? key,
    required this.label,
    required this.value,
    this.color,
     this.valueSize = AppFonts.exmedium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ?  AppColors.shadeWhiteColor : AppColors.lightgreyshade;
    final amountColor = color ??
        (isDarkMode ? const Color(0xFFEEEEEE) : AppColors.lightgreyshade);
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText(
                  title: label,
                  color: textColor,
                  size: AppFonts.small,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: LabelText(
                    color: amountColor,
                    size: valueSize,
                    weight: FontWeight.w600,
                    title: value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
