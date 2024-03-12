import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class CustomDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? indent;
  final double? thickness;
  final double? endIndent;
  const CustomDivider(
      {super.key,
      this.color = AppColors.lightwhite,
      this.endIndent = 0,
      this.height = 30,
      this.indent = 0,
      this.thickness = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color,
      thickness: thickness,
      endIndent: endIndent,
    );
  }
}


class DividerList extends StatelessWidget {
  final int count;
  final double width;
  final double height;
  final Color color;
  final double marginHorizontal;

  const DividerList({super.key, 
    this.count = 50,
    this.width = 1.5,
    this.height = 1,
    this.color = Colors.grey,
    this.marginHorizontal = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < count; i++)
          Container(
            width: width,
            height: height,
            color: color,
            margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
          ),
      ],
    );
  }
}
