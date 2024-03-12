import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double? height;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final double? width;
  final double? size;
  final Color buttonColor;
  final Color? buttonTextColor;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 1,
    this.height = 48,
    this.size = AppFonts.medium,
    this.width,
    required this.onPressed,
    this.buttonColor = AppColors.colorDarkBkue,
    this.buttonTextColor = AppColors.colorWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

    return GestureDetector(
      onTap: () async {
        isLoadingNotifier.value = true;

        try {
          await onPressed();
        } finally {
          await Future.delayed(const Duration(milliseconds: 100));

          isLoadingNotifier.value = false;
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoadingNotifier,
        builder: (context, isLoading, child) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: isLoading
                  ? const CupertinoActivityIndicator(
                      color: AppColors.colorWhite,
                    )
                  : LabelText(
                      weight: fontWeight,
                      letterSpacing: letterSpacing,
                      color: buttonTextColor,
                      title: buttonText,
                    ),
            ),
          );
        },
      ),
    );
  }
}
