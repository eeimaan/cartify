import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final double? fontSize;
  final VoidCallback? ontap;
  final TextInputType? keyboardType;
  final bool isDarkMode;
  final int? maxLines;
  final double? height;
  final Color? bgcolor;
  final Color? hintTextColor;
    final Color? borderColor;
  final double? borderRadius;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? textInputFormatter;
  final bool? readOnly;
  const TextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.borderRadius = 10,
    this.fontSize = AppFonts.medium,
    this.keyboardType,
    this.borderColor,
    required this.isDarkMode,
    this.maxLines,
    this.hintTextColor,
    this.height,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.textInputFormatter,
    this.bgcolor,
    this.readOnly = false,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = bgcolor ??
        (isDarkMode ? AppColors.appcolor : AppColors.colorLightWhite);
    final hintColor = hintTextColor??
       ( isDarkMode ? AppColors.colorDarkText : AppColors.colorLightText);
    final textLabelColor = isDarkMode
        ? Colors.white
        : Colors.black.withOpacity(0.6000000238418579);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: TextStyle(
              fontSize: AppFonts.large,
              color: textLabelColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        const SizedBox(height: 5),
        SizedBox(
          height: height,
          child: TextFormField(
            readOnly: readOnly!,
            inputFormatters: textInputFormatter,
            validator: validator,
            controller: controller,
            maxLines: maxLines,
            obscuringCharacter: '*',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // autofocus: false,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              fillColor: backgroundColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: hintColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                 borderSide:  BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius!),
                
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.colorDarkBkue,
                  width: 1.0,
                ),
               borderRadius: BorderRadius.circular(borderRadius!),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 0.5,
                ),
               borderRadius: BorderRadius.circular(borderRadius!),
              ),
              contentPadding: const EdgeInsets.only(
                top: 10,
                bottom: 5,
                left: 10,
                right: 10,
              ),
            ),
            style: TextStyle(
              color: hintColor,
              fontSize: AppFonts.medium,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
