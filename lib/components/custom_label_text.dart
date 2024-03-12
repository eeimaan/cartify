import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String title;
  final double size;
  final double? letterSpacing;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlignment;
  final TextDecoration? decoration;
  final FontWeight weight;
  final int maxLines;

  const LabelText({
    Key? key,
    this.overflow,
    this.weight = FontWeight.normal,
    this.decoration,
    this.color,
    this.textAlignment,
    this.letterSpacing,
    this.size = 17,
    required this.title,
    this.maxLines = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = color ?? (isDarkMode ? Colors.white : Colors.black);
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlignment,
      softWrap: true,
      overflow: overflow,
      style: TextStyle(
        decoration: decoration,
        fontWeight: weight,
        color: textColor,
        fontSize: size,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
