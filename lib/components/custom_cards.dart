// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/screens.dart';

class AddressCard extends StatelessWidget {
  final String name;
  final String address;
  final String buttonText;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final VoidCallback onDefault;
  const AddressCard({
    Key? key,
    required this.name,
    required this.address,
    required this.buttonText,
    required this.onEdit,
    required this.onDelete,
    required this.onDefault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? AppColors.shadeWhiteColor : AppColors.lightgreyshade;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;
    return Container(
      width: size.width,
      decoration: ShapeDecoration(
        color: containerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: ThemeColors.borderPurple(context),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImage.location,
                      width: 24,
                      height: 24,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: LabelText(
                        size: AppFonts.small,
                        weight: FontWeight.w500,
                        title: name,
                        color: textColor,
                        letterSpacing: 0.28,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    GestureDetector(
                      onTap: onDefault,
                      child: const LabelText(
                        size: AppFonts.extraSmall,
                        color: Colors.blue,
                        weight: FontWeight.w500,
                        title: 'Set as Default',
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.55,
                      child: SingleChildScrollView(
                        child: LabelText(
                          size: AppFonts.small,
                          weight: FontWeight.w500,
                          title: address,
                          color: textColor,
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            width: 40,
                            height: 32,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFCAF99C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppImage.pencil,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.darkBlack, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: onDelete,
                          child: Container(
                            width: 40,
                            height: 32,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: AppColors.colorDarkBkue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppImage.delete,
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
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
    );
  }
}

class ReminderCard extends StatelessWidget {
  final VoidCallback? onEditTap;
  final VoidCallback onDeleteTap;
  final String title;
  final bool isOpenFromEvent;
  final String subtitle;
  final String time;

  const ReminderCard({
    Key? key,
     this.onEditTap,
    this.isOpenFromEvent =  false,
    required this.onDeleteTap,
    required this.title,
    required this.time,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
     // height: size.height * 0.15,
      decoration: ShapeDecoration(
        color: ThemeColors.containerShade(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, top: 20, bottom: 12, right: 12),
        child: Row(
          children: [
            Icon(Icons.notifications_none,
                color: ThemeColors.blackWhiteColor(context)),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(
                      size: AppFonts.small,
                      color: ThemeColors.textColor(context),
                      weight: FontWeight.w800,
                      title: title),
                  LabelText(
                    overflow: TextOverflow.ellipsis,
                      size: AppFonts.small,
                      color: ThemeColors.textColor(context),
                      weight: FontWeight.w400,
                      title: subtitle),
                  LabelText(
                      size: AppFonts.small,
                      color: ThemeColors.textColor(context),
                      weight: FontWeight.w400,
                      title: time),
                ],
              ),
            ),
             Expanded(
                  flex: 1,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if(!isOpenFromEvent)
                      GestureDetector(
                        onTap: onEditTap,
                        child: Container(
                          width: 40,
                          height: 32,
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFCAF99C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset(
                            AppImage.pencil,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                AppColors.darkBlack, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: Container(
                          width: 40,
                          height: 32,
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: AppColors.colorDarkBkue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset(
                            AppImage.delete,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
