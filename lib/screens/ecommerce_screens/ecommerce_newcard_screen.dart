// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/components.dart';
// import 'package:flutter_application_1/constants/constants.dart';
// import 'package:flutter_application_1/utils/utils.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class EcommerceNewCardPage extends StatefulWidget {
//   const EcommerceNewCardPage({super.key});

//   @override
//   State<EcommerceNewCardPage> createState() => _EcommerceNewCardPageState();
// }

// class _EcommerceNewCardPageState extends State<EcommerceNewCardPage> {
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     var mediaQuery = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//           forceMaterialTransparency: true,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           color: ThemeColors.blackWhiteColor(context),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: LabelText(
//           color: ThemeColors.blackWhiteColor(context),
//           size: AppFonts.extraLarge,
//           weight: FontWeight.w600,
//           letterSpacing: 0.50,
//           title: 'Add a New Card',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                 ),
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       flex: 4,
//                       child: LabelText(
//                         title: 'Name on Card*',
//                         size: 16,
//                         weight: FontWeight.w700,
//                         letterSpacing: 0.50,
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         width: mediaQuery.width * 0.2,
//                         height: mediaQuery.height * 0.039,
//                         padding: const EdgeInsets.symmetric(vertical: 6),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               AppImage.lock,
//                               width: 12,
//                               height: 12,
//                               colorFilter: const ColorFilter.mode(
//                                   Color(0xFF8497AF), BlendMode.srcIn),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             const LabelText(
//                               title: 'Secure Form',
//                               size: 10,
//                               color: Color(0xFF8497AF),
//                               weight: FontWeight.w500,
//                               letterSpacing: 0.50,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                   bottom: 10,
//                 ),
//                 child: TextFieldWidget(
//                   hintText: 'John Doe',
//                   fontSize: 16,
//                   keyboardType: TextInputType.name,
//                   isDarkMode: isDarkMode,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                   bottom: 5,
//                 ),
//                 child: LabelText(
//                   title: 'Card Number*',
//                   size: 16,
//                   weight: FontWeight.w700,
//                   letterSpacing: 0.50,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                   bottom: 10,
//                 ),
//                 child: TextFieldWidget(
//                   hintText: '1234 1234 1234 1234',
//                   fontSize: 16,
//                   keyboardType: TextInputType.number,
//                   isDarkMode: isDarkMode,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(bottom: 5),
//                             child: LabelText(
//                               title: 'Expiry*',
//                               size: 16,
//                               weight: FontWeight.w700,
//                               letterSpacing: 0.50,
//                             ),
//                           ),
//                           TextFieldWidget(
//                             hintText: 'MM/YY',
//                             fontSize: 16,
//                             isDarkMode: isDarkMode,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     Expanded(
//                       flex: 4,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(bottom: 5),
//                             child: LabelText(
//                               title: 'CVV*',
//                               size: 16,
//                               weight: FontWeight.w700,
//                               letterSpacing: 0.50,
//                             ),
//                           ),
//                           TextFieldWidget(
//                             hintText: '123',
//                             fontSize: 16,
//                             keyboardType: TextInputType.number,
//                             isDarkMode: isDarkMode,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     Expanded(
//                       flex: 1,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: SvgPicture.asset(
//                               AppImage.creditcardIcon,
//                               width: 24,
//                               height: 24,
//                               colorFilter: const ColorFilter.mode(
//                                   Color(0xFF8497AF), BlendMode.srcIn),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 5),
//                       child: LabelText(
//                         title: 'Zip Code',
//                         size: 16,
//                         weight: FontWeight.w700,
//                         letterSpacing: 0.50,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 150,
//                       child: TextFieldWidget(
//                         hintText: '',
//                         keyboardType: TextInputType.number,
//                         fontSize: 16,
//                         isDarkMode: isDarkMode,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   right: 10,
//                   top: 20,
//                 ),
//                 child: CustomButton(
//                   buttonText: 'Save New Card',
//                   buttonColor: AppColors.lightGreenShade,
//                   onPressed: () {
//                     AppsDialogs.showAppDialog(
//                         backgroundColor: ThemeColors.backgroundColor(context),
//                         context: context,
//                         content: CustomSuccessDialog(
//                           btnText: 'View Details',
//                           message:
//                               'You have successfully added\nyour master card.',
//                           onViewDetailsPressed: () {},
//                         ));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
