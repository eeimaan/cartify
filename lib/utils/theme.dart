import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ThemeColors {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color textColorGrey(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.shadeWhiteColor
        : AppColors.lightgreyshade;
  }
   static Color borderPurple(BuildContext context) {
    return isDarkMode (context)? AppColors.jutBlack : const Color(0xFFD4C1F3);
  }
  //   static Color borderGreen(BuildContext context) {
  //   return isDarkMode (context)? AppColors.greenish : const Color(0xFFD4C1F3);
  // }

  static Color backgroundColor(BuildContext context) {
    return isDarkMode(context) ? Colors.black : Colors.white;
  }

  static Color lineColor(BuildContext context) {
    return isDarkMode(context) ? AppColors.colorYellow : AppColors.colorBlue;
  }

  static Color dividerColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.colorWhite.withOpacity(0.25)
        : Colors.black.withOpacity(0.20000000298023224);
  }

  static Color buttonColor(BuildContext context) {
    return isDarkMode(context) ? AppColors.darkButton : AppColors.lightwhite;
  }

  static Color bluePurpleText(BuildContext context) {
    return isDarkMode(context) ? AppColors.colorBlue : AppColors.colorPurple;
  }

  static Color blackWhiteColor(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }

  static Color greyContainer(BuildContext context) {
    return isDarkMode(context) ? Colors.white : AppColors.shadeGrey;
  }

  static Color blackShade(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.colorWhite.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);
  }

  static Color containerText(BuildContext context) {
    return isDarkMode(context) ? Colors.black : Colors.white;
  }

  static Color textColor(BuildContext context) {
    return isDarkMode(context) ? AppColors.whiteShade : AppColors.lightBlack;
  }

  static Color containerColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.jutBlack.withOpacity(0.80)
        : AppColors.colorWhite.withOpacity(0.60);
  }

  static Color textGreyColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.shadeWhiteColor
        : AppColors.lightgreyshade;
  }

  static Color containerShade(BuildContext context) {
    return isDarkMode(context) ? AppColors.lightBlack : AppColors.lightwhite;
  }

  static Color textColorShade(BuildContext context) {
    return isDarkMode(context) ? AppColors.whiteShade : AppColors.lightBlack;
  }

  static Color textColorBlack(BuildContext context) {
    return isDarkMode(context) ? Colors.white : AppColors.colorLightText;
  }

  static Color textGreenBlue(BuildContext context) {
    return isDarkMode(context) ? AppColors.lightText : AppColors.colorDarkBkue;
  }

  static Color textWelcome(BuildContext context) {
    return isDarkMode(context) ? Colors.white : AppColors.colorDarkText;
  }
}
