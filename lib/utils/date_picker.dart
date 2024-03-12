// import 'package:bottom_picker/bottom_picker.dart';
// import 'package:bottom_picker/resources/arrays.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_application_1/constants/constants.dart';
// import 'package:flutter_application_1/utils/utils.dart';

// class DateOfBirth {
//   static void openDatePicker(
//     BuildContext context, {
//     TextEditingController? ageController,
//     ValueNotifier<DateTime>? timeNotifier,
//     DateTime? minimumDate,
//   }) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final fillColor = isDarkMode ? Colors.black : Colors.white;
//     BottomPicker.date(
//       backgroundColor: fillColor,
//       title: 'Select date',
//       dateOrder: DatePickerDateOrder.dmy,
//       initialDateTime: DateTime.now(),
//       minDateTime: minimumDate ?? DateTime(1900),
//       pickerTextStyle: const TextStyle(
//         color: AppColors.colorLightText,
//         fontSize: AppFonts.medium,
//         fontWeight: FontWeight.w400,
//         letterSpacing: 1,
//       ),
//       titleStyle: const TextStyle(
//         fontSize: AppFonts.large,
//         fontWeight: FontWeight.w600,
//         color: AppColors.colorRed,
//       ),
//       onChange: (index) {
//         // print(index);
//       },
//       buttonSingleColor: AppColors.colorRed,
//       onSubmit: (selectedDate) {
//         if (selectedDate.isAfter(minimumDate)) {
//           SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//             SnackBarHelper.showSnackBar(
//               context,
//               'invalid date',
//             );
//           });
//         } else {
//           if (ageController != null) {
//             ageController.text =
//                 selectedDate.toLocal().toString().split(' ')[0];
//           }
//           if (timeNotifier != null) {
//             timeNotifier.value = selectedDate;
//           }
//         }
//       },
//       bottomPickerTheme: BottomPickerTheme.plumPlate,
//     ).show(context);
//   }
// }
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';

class DateOfBirth {
  static void openDatePicker(BuildContext context,
      {TextEditingController? ageController,
      ValueNotifier<DateTime>? timeNotifier}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDarkMode ? Colors.black : Colors.white;

    BottomPicker.date(
      backgroundColor: fillColor,
      title: 'Select date',
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(1900),
      pickerTextStyle: const TextStyle(
        color: AppColors.colorLightText,
        fontSize: AppFonts.medium,
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
      ),
      titleStyle: const TextStyle(
        fontSize: AppFonts.large,
        fontWeight: FontWeight.w600,
        color: AppColors.colorDarkBkue,
      ),
      onChange: (index) {
        // print(index);
      },
      buttonSingleColor: AppColors.colorDarkBkue,
      onSubmit: (selectedDate) {
        if (ageController != null) {
          ageController.text = selectedDate.toLocal().toString().split(' ')[0];
        }
        if (timeNotifier != null) {
          timeNotifier.value = selectedDate;
        }
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }
}
