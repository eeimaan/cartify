// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/components.dart';
// import 'package:flutter_application_1/constants/constants.dart';
// import 'package:flutter_application_1/models/ecommerce_models.dart';
// import 'package:flutter_application_1/screens/screens.dart';
// import 'package:flutter_application_1/utils/utils.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hive/hive.dart';

// class PageEcommerce extends StatefulWidget {
//   const PageEcommerce({super.key});

//   @override
//   State<PageEcommerce> createState() => _PageEcommerceState();
// }

// class _PageEcommerceState extends State<PageEcommerce> {

//   final box = Hive.box();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, AppRoutes.ecommerceCartPage);
//               },
//               child: SvgPicture.asset(
//                 AppImage.addCartIcon,
//                 colorFilter: ColorFilter.mode(
//                     ThemeColors.blackWhiteColor(context), BlendMode.srcIn),
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.067,
//               width: size.width * 0.7,
//             ),
//             SizedBox(
//                 height: size.height * 0.067,
//                 width: size.width * 0.7,
//                 child:
//                     CustomButton(buttonText: 'Add to Cart', onPressed: () {
//                       final product = ProductModel(image: image)

// final bumble = Bee(name: 'Bumble', role: 'Worker');
// box.put('BumbleID', bumble);

// print(box.get('BumbleID'));




//                     })),
//           ],
//         ),
//       ),
//     );
//   }
// }
