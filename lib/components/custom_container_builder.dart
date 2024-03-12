import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/welcome_screens/status_screen.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomEcommerceContainer extends StatelessWidget {
  final String? imagePath;
  final String? label;
  final double? height;
  final double? width;
  final String? price;

  const CustomEcommerceContainer({
    Key? key,
    this.width,
    this.height,
    this.imagePath,
    this.label,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    log(mediaQuery.height.toString());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDarkMode ? AppColors.colorBlack : AppColors.containerColor;
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
          border: Border.all(
            color: ThemeColors.borderPurple(context),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.white12 : Colors.black12,
              offset: const Offset(1, 1),
              blurRadius: 2.0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.45,
              height: size.width * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagePath!),
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 2,
              ),
              child: LabelText(
                title: '$label',
                size: AppFonts.small,
                weight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImage.priceTag,
                    height: 14,
                    width: 14,
                    colorFilter: const ColorFilter.mode(
                        AppColors.colorBlue, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  LabelText(
                    title: '$price',
                    size: AppFonts.small,
                    weight: FontWeight.w500,
                    color: AppColors.colorBlue,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomViewContainer extends StatefulWidget {
  final String labelText;
  final bool isSelected;
  final Function(bool) onSelect;

  const CustomViewContainer({
    Key? key,
    required this.labelText,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  CustomViewContainerState createState() => CustomViewContainerState();
}

class CustomViewContainerState extends State<CustomViewContainer> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.colorWhite : Colors.black;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;

    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 80,
          height: 24,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: ShapeDecoration(
            color: widget.isSelected
                ? isDarkMode
                    ? Colors.white
                    : AppColors.colorDarkBkue
                : containerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LabelText(
                title: widget.labelText,
                color: widget.isSelected
                    ? isDarkMode
                        ? Colors.black
                        : AppColors.colorWhite
                    : textColor,
                size: 10,
                weight: FontWeight.w500,
                letterSpacing: 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomReviewContainer extends StatefulWidget {
  final String labelText;
  final bool isSelected;
  final Function(bool) onSelect;

  const CustomReviewContainer({
    Key? key,
    required this.labelText,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  CustomReviewContainerState createState() => CustomReviewContainerState();
}

class CustomReviewContainerState extends State<CustomReviewContainer> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = widget.isSelected
        ? (isDarkMode ? AppColors.richText : AppColors.richText)
        : (isDarkMode ? Colors.black : Colors.white);
    final borderColor = widget.isSelected
        ? (isDarkMode ? AppColors.richText : AppColors.richText)
        : (isDarkMode ? AppColors.richText : AppColors.shadeGrey);
    final textColor = widget.isSelected
        ? (isDarkMode ? AppColors.colorWhite : AppColors.colorWhite)
        : (isDarkMode ? AppColors.richText : AppColors.shadeGrey);

    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 83,
          height: 38,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: ShapeDecoration(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color: borderColor,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImage.reviewStar,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  textColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              LabelText(
                title: widget.labelText,
                color: textColor,
                size: 14,
                weight: FontWeight.w500,
                letterSpacing: 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomReview extends StatelessWidget {
  final String labelText;

  const CustomReview({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? AppColors.darkBlack : AppColors.colorWhite;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 60,
          height: 32,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: ShapeDecoration(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(
                color: AppColors.richText,
                width: 2.0,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImage.reviewStar,
                width: 16,
                height: 16,
                colorFilter:
                    const ColorFilter.mode(AppColors.richText, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 10,
              ),
              LabelText(
                title: labelText,
                color: AppColors.richText,
                size: 14,
                weight: FontWeight.w500,
                letterSpacing: 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOrder extends StatelessWidget {
  final String labelText;
  final Color color;
  final Color labelColor;
  final VoidCallback? onTap;

  const CustomOrder({
    Key? key,
    required this.labelText,
    required this.color,
    required this.labelColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: LabelText(
              title: labelText,
              color: labelColor,
              size: AppFonts.small,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomThumbnailCard extends StatelessWidget {
  final String time;
  final String title;
  final bool isAllPlans;
  final Future<Uint8List?> Function() thumbnailFuture;
  final Function() onDeletePressed;

  const CustomThumbnailCard({
    Key? key,
    required this.time,
    required this.isAllPlans,
    required this.title,
    required this.thumbnailFuture,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: ShapeDecoration(
          color: ThemeColors.containerShade(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            // side: BorderSide(
            //  // color: ThemeColors.borderPurple(context),
            //   width: 0.4,
            // ),
          ),
        ),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            FutureBuilder<Uint8List?>(
              future: thumbnailFuture(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error generating thumbnail');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.fill,
                      height: 260,
                      width: size.width,
                    ),
                  );
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              },
            ),
            CustomShapeContainer(
              width: 185,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: ShapeDecoration(
                color: ThemeColors.containerColor(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(
                      title: time,
                      color: ThemeColors.textGreenBlue(context),
                      size: 11,
                      weight: FontWeight.w500,
                      letterSpacing: 0.50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelText(
                          title: title,
                          size: AppFonts.extraSmall,
                          weight: FontWeight.w600,
                          letterSpacing: 0.50,
                        ),
                        if (isAllPlans)
                          InkWell(
                            onTap: onDeletePressed,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.colorDarkBkue,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
