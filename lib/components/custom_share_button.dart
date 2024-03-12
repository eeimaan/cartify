import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShareProgressButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final BorderRadiusGeometry? borderRadius;
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;
  const ShareProgressButton({
    Key? key,
    required this.label,
    required this.imagePath,
    this.borderRadius,
    this.buttonColor = AppColors.colorBlue,
    this.textColor = AppColors.colorWhite,
    this.iconColor = AppColors.colorWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.9,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            LabelText(
              color: textColor,
              size: AppFonts.exmedium,
              weight: FontWeight.w600,
              letterSpacing: 1,
              title: label,
            ),
          ],
        ),
      ),
    );
  }
}
