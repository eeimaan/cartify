// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String price;
  final VoidCallback? onDelete;
  final VoidCallback? onTapIncrement;
  final VoidCallback? onTapDecrement;
  final String itemCount;
  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.price,
    this.onDelete,
    this.onTapIncrement,
    this.onTapDecrement,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var mediaQuery = MediaQuery.of(context).size;
    final containerColor = isDarkMode
        ? AppColors.lightBlack.withOpacity(0.5)
        : AppColors.lightwhite;
    final color =
        isDarkMode ? AppColors.shadeDarkGreen : const Color(0xFFF3F5F7);
    final iconColor =
        isDarkMode ? AppColors.colorWhite : const Color(0xFF617885);

    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: SizedBox(
        width: size.width,
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ThemeColors.borderPurple(context),
                  width: 0.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 64,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(1),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelText(
                          title: label.length <= 22
                              ? label
                              : '${label.substring(0, 22)}...',
                          size: AppFonts.small,
                          weight: FontWeight.w600,
                          letterSpacing: 0.50,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: mediaQuery.width * 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelText(
                                  color: AppColors.colorBlue,
                                  size: 14,
                                  weight: FontWeight.w500,
                                  letterSpacing: 0.50,
                                  title: price),
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: onTapDecrement,
                                        child: Icon(
                                          Icons.remove,
                                          color: iconColor,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: LabelText(
                                          size: 14,
                                          weight: FontWeight.w500,
                                          letterSpacing: 0.50,
                                          title: itemCount),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: GestureDetector(
                                      onTap: onTapIncrement,
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.colorWhite,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: onDelete,
              child: SvgPicture.asset(
                AppImage.delete,
                width: 25,
                height: 25,
                colorFilter: const ColorFilter.mode(
                  AppColors.colorDarkBkue,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderProductCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final int qty;
  final String price;

  const OrderProductCard(
      {super.key,
      required this.imagePath,
      required this.label,
      required this.price,
      required this.qty});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var mediaQuery = MediaQuery.of(context).size;
    final containerColor = isDarkMode
        ? AppColors.lightBlack.withOpacity(0.5)
        : AppColors.lightwhite;
    return Row(
      children: [
        Container(
          width: mediaQuery.width*0.92,
          height: 64,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10),
           
             border: Border.all(
                    color: ThemeColors.borderPurple(context),
                    width: 0.5,
                  ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 64,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(
                      title: label.length <= 19
                          ? label
                          : '${label.substring(0, 19)}...',
                      size: AppFonts.small,
                      weight: FontWeight.w600,
                      letterSpacing: 0.50,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            LabelText(
                              color: AppColors.colorBlue,
                              size: 14,
                              weight: FontWeight.w500,
                              letterSpacing: 0.50,
                              title: price,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: mediaQuery.width * 0.37,
                        ),
                        Column(
                          children: [
                            LabelText(
                              size: 14,
                              weight: FontWeight.w500,
                              letterSpacing: 0.50,
                              title: 'Qty=$qty',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomProductItem extends StatelessWidget {
  final String imageAsset;
  final String productName;
  final String quantity;
  final String price;
  final String orderStatus;
  final String trackOrderText;
  final Color orderStatusColor;
  final VoidCallback onTapOrder;

  const CustomProductItem({
    super.key,
    required this.imageAsset,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.orderStatus,
    required this.trackOrderText,
    required this.orderStatusColor,
    required this.onTapOrder,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var mediaQuery = MediaQuery.of(context).size;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;

    return Container(
      width: size.width,
      height: size.width * 0.34,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.0,
          color: containerColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.25,
            height: size.width * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageAsset),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(1),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mediaQuery.width * 0.57,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelText(
                        title: productName,
                        size: AppFonts.small,
                        weight: FontWeight.w600,
                        letterSpacing: 0.50,
                      ),
                      LabelText(
                        title: quantity,
                        size: AppFonts.small,
                        weight: FontWeight.w500,
                        letterSpacing: 0.50,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: LabelText(
                    title: price,
                    size: AppFonts.small,
                    weight: FontWeight.w500,
                    color: Colors.blue,
                    letterSpacing: 0.50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: mediaQuery.width * 0.57,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomOrder(
                            labelText: orderStatus,
                            color: const Color(0x19EA5660),
                            labelColor: orderStatusColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: onTapOrder,
                            child: CustomOrder(
                              labelText: trackOrderText,
                              color: AppColors.colorDarkBkue,
                              labelColor: AppColors.colorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
