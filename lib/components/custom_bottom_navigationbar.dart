// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/constants.dart';
// import 'package:flutter_application_1/utils/call_backs_func.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   final NavigateCurrentIndex? getSelectedIndex;

//   const CustomBottomNavigationBar({Key? key, this.getSelectedIndex})
//       : super(key: key);

//   @override
//   CustomBottomNavigationBarState createState() =>
//       CustomBottomNavigationBarState();
// }

// class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   late ValueNotifier<int> _selectedIndexNotifier;
// //  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
// //   final selectedColor = isDarkMode ? Colors.white : AppColors.lightgreyshade;
// //   final unSelectedColor =
// //       isDarkMode ? AppColors.darkBlack : AppColors.naviconColor;
//   @override
//   void initState() {
//     super.initState();
//     _selectedIndexNotifier = ValueNotifier<int>(0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       showSelectedLabels: true,
//       currentIndex: _selectedIndexNotifier.value,
//       showUnselectedLabels: true,
//       selectedFontSize: 12,
//       //  selectedItemColor: ,
//       //  unselectedItemColor: ,
//       unselectedFontSize: 12,
//       onTap: (index) {
//         _selectedIndexNotifier.value = index;
//         widget.getSelectedIndex!(index);
//       },
//       items: [
//         _bottomNavigationView(
//           svgAssetPath: AppImage.home,
//           label: 'Home',
//           index: 0,
//         ),
//         _bottomNavigationView(
//           svgAssetPath: AppImage.nutrition,
//           label: 'Nutrition',
//           index: 1,
//         ),
//         _bottomNavigationView(
//           svgAssetPath: AppImage.exercise,
//           label: 'Exercise',
//           index: 2,
//         ),
//         _bottomNavigationView(
//           svgAssetPath: AppImage.virtual,
//           label: 'Virtual Trainer',
//           index: 3,
//         ),
//         _bottomNavigationView(
//           svgAssetPath: AppImage.community,
//           label: 'Community',
//           index: 4,
//         ),
//         _bottomNavigationView(
//           svgAssetPath: AppImage.store,
//           label: 'Store',
//           index: 5,
//         ),
//       ],
//     );
//   }

//   BottomNavigationBarItem _bottomNavigationView(
//       {required String svgAssetPath,
//       required String label,
//       required int index}) {
//     return BottomNavigationBarItem(
//       icon: ValueListenableBuilder<int>(
//         valueListenable: _selectedIndexNotifier,
//         builder: (context, selectedIndex, _) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 svgAssetPath,
//                 width: 24,
//                 height: 24,
//                 colorFilter: ColorFilter.mode(
//                   _getColor(index, selectedIndex),
//                   BlendMode.srcIn,
//                 ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 label,
//                 style: TextStyle(
//                     fontSize: 10, color: _getColor(index, selectedIndex)),
//               ),
//             ],
//           );
//         },
//       ),
//       label: "",
//     );
//   }

//   Color _getColor(int index, int selectedIndex) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     if (isDarkMode) {
//       return selectedIndex == index ? Colors.white : AppColors.lightgreyshade;
//     } else {
//       return selectedIndex == index
//           ? AppColors.darkBlack
//           : AppColors.naviconColor;
//     }
//   }

//   @override
//   void dispose() {
//     _selectedIndexNotifier.dispose();
//     super.dispose();
//   }
// }
