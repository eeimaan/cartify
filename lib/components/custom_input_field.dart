import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ChatTextField extends StatelessWidget {
  final String? hinText;
  final double? height;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxDecoration? decoration;
  final bool isVisibleText;
  final Color? fillColor;
  final double? width;
  final double radius;
  final TextStyle? suffixStyle;
  final IconData? iconData;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;

  const ChatTextField({
    super.key,
    this.iconData,
    this.height,
    this.controller,
    this.prefixIcon,
    this.decoration,
    this.suffixStyle,
    this.hinText,
    this.fillColor,
    this.isVisibleText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.radius = 10,
    this.width,
    this.hintColor,
  });

  @override
  build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: null,
        minLines: null,
        style: const TextStyle(color: AppColors. lightgreyshade),
        obscureText: isVisibleText,
        obscuringCharacter: '●',
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          hintText: hinText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.exmedium,
              letterSpacing: 1,
              color: hintColor),
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          suffixStyle: suffixStyle,
          filled: true,
        ),
      ),
    );
  }
}
