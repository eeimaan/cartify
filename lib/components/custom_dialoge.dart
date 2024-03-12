import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomSuccessDialog extends StatelessWidget {
  final String message;
  final VoidCallback onViewDetailsPressed;
  final String btnText;

  const CustomSuccessDialog({
    super.key,
    required this.message,
    required this.onViewDetailsPressed,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.48,
      width: mediaQuery.size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const CustomSize(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppImage.greenBall,
                    scale: 1.2,
                  ),
                  Image.asset(AppImage.trueIcon, scale: 1.5),
                  Positioned(
                      right: -5,
                      top: -1,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 8,
                      )),
                  Positioned(
                      left: -10,
                      top: -1,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 8,
                      )),
                  Positioned(
                      top: -8,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 28,
                      )),
                  Positioned(
                      left: -10,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 50,
                      )),
                  Positioned(
                      bottom: -1,
                      left: -3,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 15,
                      )),
                  Positioned(
                      bottom: -10,
                      left: 30,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      )),
                  Positioned(
                      right: 25,
                      bottom: -4,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 50,
                      )),
                  Positioned(
                      right: -5,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      )),
                  Positioned(
                      right: -10,
                      bottom: 20,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      )),
                ],
              ),
              const CustomSize(
                height: 30,
              ),
              LabelText(
                title: 'Congratulations!',
                textAlignment: TextAlign.center,
                color: iconColor,
                size: 24,
                weight: FontWeight.w600,
              ),
              const CustomSize(
                height: 30,
              ),
              LabelText(
                title: message,
                textAlignment: TextAlign.center,
                color: iconColor,
                size: AppFonts.exmedium,
                weight: FontWeight.w400,
                letterSpacing: 0.30,
              ),
              const CustomSize(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonText: btnText,
                  onPressed: onViewDetailsPressed,
                ),
              )
            ],
          ),
          Positioned(
            top: -3,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomReviewDialog extends StatefulWidget {
  final VoidCallback onSubmitted;
  final VoidCallback onCancel;
  final TextEditingController textEditingController;

  const CustomReviewDialog({
    super.key,
    required this.onSubmitted,
    required this.onCancel,
    required this.textEditingController,
  });

  @override
  State<CustomReviewDialog> createState() => _CustomReviewDialogState();
}

class _CustomReviewDialogState extends State<CustomReviewDialog> {
  ValueNotifier<int> selectedStarNotifier = ValueNotifier(1);
  late ReviewProvider reviewProvider;
  final ValueNotifier<int> rating = ValueNotifier<int>(0);

  @override
  void initState() {
    reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Container(
        height: mediaQuery.size.height * 0.6,
        width: mediaQuery.size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: LabelText(
                    title: 'Leave a Review',
                    color: iconColor,
                    size: 20,
                    weight: FontWeight.w700,
                    letterSpacing: 0.20,
                  ),
                ),
                const CustomDivider(),
                Center(
                  child: ValueListenableBuilder(
                    valueListenable: selectedStarNotifier,
                    builder: (context, index, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStar(1),
                        buildStar(2),
                        buildStar(3),
                        buildStar(4),
                        buildStar(5),
                      ],
                    ),
                  ),
                ),
                const CustomSize(
                  height: 15,
                ),
                Center(
                  child: LabelText(
                    title: 'How is your order?',
                    textAlignment: TextAlign.center,
                    color: iconColor,
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                ),
                const CustomSize(
                  height: 10,
                ),
                LabelText(
                  title: 'Please give your rating & also your review...',
                  textAlignment: TextAlign.center,
                  color: iconColor,
                  size: AppFonts.small,
                  weight: FontWeight.w400,
                  letterSpacing: 0.20,
                ),
                const CustomSize(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: LabelText(
                    title: 'Feedback',
                    color: iconColor,
                    size: AppFonts.small,
                    weight: FontWeight.w600,
                    letterSpacing: 0.20,
                  ),
                ),
                TextFieldWidget(
                  hintText: 'Write feedback here',
                  fontSize: 16,
                  height: 120,
                  controller: widget.textEditingController,
                  maxLines: 40,
                  isDarkMode: isDarkMode,
                ),
                const CustomSize(
                  height: 13,
                ),
                SizedBox(
                  width: mediaQuery.size.width * 0.65,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: CustomButton(
                          buttonText: 'Cancel',
                          buttonTextColor: iconColor,
                          buttonColor: containerColor,
                          onPressed: widget.onCancel,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: CustomButton(
                          buttonText: 'Submit',
                          onPressed: widget.onSubmitted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -2,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStar(int starIndex) {
    return GestureDetector(
      onTap: () {
        if (selectedStarNotifier.value < starIndex) {
          rating.value = (rating.value == starIndex) ? 0 : starIndex;
        } else {
          rating.value = (rating.value == starIndex) ? 0 : starIndex;
        }
        log('Tapped star index: $starIndex');
        reviewProvider.setReviewCount(starIndex);
      },
      child: ValueListenableBuilder<int>(
        valueListenable: rating,
        builder: (context, value, child) {
          return SvgPicture.asset(
            AppImage.reviewStar,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              (starIndex <= value)
                  ? AppColors.lightGreen
                  : ThemeColors.containerShade(context),
              BlendMode.srcIn,
            ),
          );
        },
      ),
    );
  }
}

class OrderDialog extends StatelessWidget {
  final VoidCallback onViewOrderPressed;
  final VoidCallback onViewEReceiptPressed;

  const OrderDialog({
    super.key,
    required this.onViewOrderPressed,
    required this.onViewEReceiptPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    // final containerColor =
    //     isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;

    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomSize(
                height: 10,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppImage.greenBall,
                    scale: 1.2,
                  ),
                  SvgPicture.asset(
                    AppImage.ordercomplete,
                  ),
                  Positioned(
                      right: -5,
                      top: -1,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 8,
                      )),
                  Positioned(
                      left: -10,
                      top: -1,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 8,
                      )),
                  Positioned(
                      top: -8,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 28,
                      )),
                  Positioned(
                      left: -10,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 50,
                      )),
                  Positioned(
                      bottom: -1,
                      left: -3,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 15,
                      )),
                  Positioned(
                      bottom: -10,
                      left: 30,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      )),
                  Positioned(
                      right: 25,
                      bottom: -4,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 50,
                      )),
                  Positioned(
                      right: -5,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      )),
                  Positioned(
                      right: -10,
                      bottom: 20,
                      child: Image.asset(
                        AppImage.greenBall,
                        scale: 30,
                      ))
                ],
              ),
              const CustomSize(
                height: 30,
              ),
              LabelText(
                title: 'Order Successful!',
                textAlignment: TextAlign.center,
                color: iconColor,
                size: 24,
                weight: FontWeight.w600,
              ),
              const CustomSize(
                height: 30,
              ),
              LabelText(
                title: 'You have successfully made an order',
                textAlignment: TextAlign.center,
                color: iconColor,
                size: AppFonts.exmedium,
                weight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
              const CustomSize(
                height: 20,
              ),
              CustomButton(
                buttonText: 'View Order',
                onPressed: onViewOrderPressed,
              ),
              const CustomSize(
                height: 10,
              ),
              CustomButton(
                buttonText: 'View E-Receipt',
                buttonTextColor: iconColor,
                buttonColor: const Color(0xFFD8D8D8),
                onPressed: onViewEReceiptPressed,
              ),
            ],
          ),
          Positioned(
            top: -2,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickDialog extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  const ImagePickDialog({
    super.key,
    required this.onGallery,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;

    return Container(
      height: MediaQuery.of(context).size.height * 0.19,
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const CustomSize(
                height: 20,
              ),
              CustomButton(
                buttonText: 'Select from gallery',
                onPressed: onGallery,
              ),
              const CustomSize(
                height: 10,
              ),
              CustomButton(
                buttonText: 'Select from Camera',
                buttonTextColor: iconColor,
                buttonColor: containerColor,
                onPressed: onCamera,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageVideoPickDialog extends StatelessWidget {
  final VoidCallback onImage;
  final VoidCallback onVideo;

  const ImageVideoPickDialog({
    super.key,
    required this.onImage,
    required this.onVideo,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSize(
            height: 10,
          ),
          LabelText(
            title: 'What You want to Upload?',
            color: iconColor,
            size: 18,
            weight: FontWeight.w400,
            letterSpacing: 0.20,
          ),
          const CustomSize(
            height: 10,
          ),
          CustomButton(
            buttonText: 'Image',
            onPressed: onImage,
          ),
          const CustomSize(
            height: 10,
          ),
          CustomButton(
            buttonText: 'Video',
            buttonTextColor: iconColor,
            buttonColor: containerColor,
            onPressed: onVideo,
          ),
        ],
      ),
    );
  }
}

class SleepTimeDialog extends StatelessWidget {
  final ValueNotifier<TimeOfDay> sleepTimeNotifier;
  final ValueNotifier<TimeOfDay> awakeTimeNotifier;
  final VoidCallback onConfirm;

  const SleepTimeDialog({
    Key? key,
    required this.sleepTimeNotifier,
    required this.awakeTimeNotifier,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    //  final containerColor = isDarkMode ? Colors.black : Colors.white;

    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              LabelText(
                title: 'Edit Your time',
                color: iconColor,
                size: 18,
                weight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
              const SizedBox(height: 20),
              _buildTimePicker(
                title: 'Sleep Time',
                timeNotifier: sleepTimeNotifier,
                context: context,
              ),
              const SizedBox(height: 20),
              _buildTimePicker(
                title: 'Awake Time',
                timeNotifier: awakeTimeNotifier,
                context: context,
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: 'Confirm',
                buttonTextColor: AppColors.colorWhite,
                buttonColor: AppColors.colorYellow,
                onPressed: onConfirm,
              ),
              const SizedBox(height: 20),
            ],
          ),
          Positioned(
            top: -2,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker({
    required String title,
    required ValueNotifier<TimeOfDay> timeNotifier,
    required BuildContext context,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final colorScheme = isDarkMode
        ? const ColorScheme.dark(
            primary: Colors.yellow,
          )
        : const ColorScheme.light(
            primary: Colors.yellow,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        InkWell(
          onTap: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: timeNotifier.value,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: false,
                    primaryColor: backgroundColor,
                    hintColor: textColor,
                    secondaryHeaderColor: textColor,
                    colorScheme: colorScheme,
                    buttonTheme: const ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedTime != null) {
              timeNotifier.value = pickedTime;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: ValueListenableBuilder<TimeOfDay>(
              valueListenable: timeNotifier,
              builder: (context, selectedTime, _) {
                return Text(
                  selectedTime.format(context),
                  style: TextStyle(fontSize: 16, color: textColor),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class CustomAlertDialog extends StatelessWidget {
//   final String message;
//   final VoidCallback onViewDetailsPressed;
//   final String btnText;

//   const CustomAlertDialog({
//     super.key,
//     required this.message,
//     required this.onViewDetailsPressed,
//     required this.btnText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final iconColor = isDarkMode ? Colors.white : Colors.black;

//     final mediaQuery = MediaQuery.of(context);

//     return Container(
//       height: mediaQuery.size.height * 0.22,
//       width: mediaQuery.size.width * 0.5,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               const CustomSize(
//                 height: 40,
//               ),
//               LabelText(
//                 title: message,
//                 textAlignment: TextAlign.center,
//                 color: iconColor,
//                 size: AppFonts.exmedium,
//                 weight: FontWeight.w400,
//                 letterSpacing: 0.30,
//               ),
//               const CustomSize(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomButton(
//                   buttonText: btnText,
//                   onPressed: onViewDetailsPressed,
//                 ),
//               )
//             ],
//           ),
//           Positioned(
//             top: -3,
//             right: 0,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: const Icon(
//                 Icons.close,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomDialog extends StatelessWidget {
  final TextEditingController nameController;
  final bool isOpenFromNutrition;

  final VoidCallback onSave;
  final TextEditingController addressController;

  const CustomDialog({
    super.key,
    required this.isOpenFromNutrition,
    required this.nameController,
    required this.onSave,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 340,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CustomSize(
                    height: 40,
                  ),
                  LabelText(
                    title: isOpenFromNutrition ? 'Meal Name' : 'Name',
                    textAlignment: TextAlign.center,
                    size: AppFonts.exmedium,
                    weight: FontWeight.w400,
                    letterSpacing: 0.30,
                  ),
                  TextFieldWidget(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    hintText: isOpenFromNutrition ? 'Meal Name' : 'Name',
                    isDarkMode: isDarkMode,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const CustomSize(
                    height: 10,
                  ),
                  LabelText(
                    title: isOpenFromNutrition ? 'Calories' : 'Address',
                    textAlignment: TextAlign.center,
                    size: AppFonts.exmedium,
                    weight: FontWeight.w400,
                    letterSpacing: 0.30,
                  ),
                  TextFieldWidget(
                    controller: addressController,
                    keyboardType: isOpenFromNutrition
                        ? TextInputType.number
                        : TextInputType.emailAddress,
                    hintText: isOpenFromNutrition ? 'Calories' : 'Address',
                    isDarkMode: isDarkMode,
                    textInputFormatter: isOpenFromNutrition
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return isOpenFromNutrition
                            ? 'Please enter calories'
                            : 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  const CustomSize(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: CustomButton(
                      buttonColor: isOpenFromNutrition
                          ? AppColors.colorDarkBkue
                          : AppColors.colorBlue,
                      buttonText: 'save',
                      onPressed: onSave,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: -3,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomLiveEnded extends StatelessWidget {
  const CustomLiveEnded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.2,
      width: mediaQuery.size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const CustomSize(
                height: 20,
              ),
              LabelText(
                title: 'Live End!',
                textAlignment: TextAlign.center,
                color: iconColor,
                size: 24,
                weight: FontWeight.w600,
              ),
              const CustomSize(
                height: 30,
              ),
              Center(
                child: LabelText(
                  title: 'Admin ended live session',
                  textAlignment: TextAlign.center,
                  color: iconColor,
                  size: AppFonts.exmedium,
                  weight: FontWeight.w400,
                  letterSpacing: 0.30,
                ),
              ),
              const CustomSize(
                height: 20,
              ),
            ],
          ),
          Positioned(
            top: -3,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InternetConnectivityDialog extends StatelessWidget {
  InternetConnectivityDialog({super.key});

  final Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    final mediaQuery = MediaQuery.of(context);

    return PopScope(
      canPop: false,
      child: Container(
        height: 200,
        width: mediaQuery.size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSize(
              height: 20,
            ),
            LabelText(
              title: 'Failed to connect to internet',
              textAlignment: TextAlign.center,
              color: iconColor,
              size: 24,
              weight: FontWeight.w600,
            ),
            const CustomSize(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonText: 'Try again',
                onPressed: () {
                  connectivity.checkConnectivity().then((result) {
                    if (result == ConnectivityResult.none) {
                      SnackBarHelper.showSnackBar(
                          context, 'No internet connection.');
                    } else {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ),
            const CustomSize(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
