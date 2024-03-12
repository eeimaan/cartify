import 'package:flutter/material.dart';
class CustomSize extends StatelessWidget {
  final double? height;
  final double? width;
  const CustomSize({super.key,this.height,this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,width: width,);
  }
}
