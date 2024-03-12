// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/constants.dart';

// class CustomSearchField extends StatelessWidget {
//   final String hintText;

//   const CustomSearchField({Key? key, required this.hintText}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     final backgroundColor =
//         isDarkMode ? AppColors.appcolor : AppColors.colorLightWhite;
//     return TextField(
      
//       style: TextStyle(color: backgroundColor),
//       decoration: InputDecoration(
//         filled: true,
        
//         prefixIcon: Icon(
//           Icons.search,
//           color: Theme.of(context).brightness == Brightness.light
//               ? AppColors.colorLightText
//               : Colors.white,
//         ),
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: Theme.of(context).brightness == Brightness.light
//               ? AppColors.colorLightText
//               : Colors.white,
//         ),
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: Colors.transparent),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: Colors.transparent),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: Colors.transparent),
//         ),
//       ),
//       onChanged: (value) {},
//     );
//   }
// }
