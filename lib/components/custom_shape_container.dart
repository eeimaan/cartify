import 'package:flutter/material.dart';

class CustomShapeContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final ShapeDecoration? decoration;
  const CustomShapeContainer(
      {super.key,
      this.decoration,
      this.width,
      this.height,
      this.child,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}

class CustomRoundedClipper extends CustomClipper<Path> {
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;

  CustomRoundedClipper({
    required this.bottomLeftRadius,
    required this.bottomRightRadius,
    required this.topLeftRadius,
    required this.topRightRadius,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height - bottomLeftRadius);
    path.lineTo(0, topLeftRadius);
    path.quadraticBezierTo(0, 0, topLeftRadius, 0);

    path.lineTo(size.width - topRightRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, topRightRadius);

    path.lineTo(size.width, size.height - bottomRightRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - bottomRightRadius, size.height);

    path.lineTo(bottomLeftRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - bottomLeftRadius);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
