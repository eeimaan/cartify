// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/constants.dart';
// import '../db_services/db_services.dart';

// class LogoWidget extends StatelessWidget {
//   final String imagePath;

//   const LogoWidget({super.key, required this.imagePath});

//   static Widget buildLogo(String imagePath) {
//     return LogoWidget(imagePath: imagePath);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final Color borderColor = isDarkMode ? Colors.black : Colors.white;

//     return SizedBox(
//       height: 60,
//       width: 60,
//       child: MaterialButton(
//         visualDensity: VisualDensity.compact,
//         padding: const EdgeInsets.only(right: 8),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//             side: BorderSide(color: borderColor)),
//         onPressed: () async {
//           if (imagePath == AppImage.googleLogo ||
//               imagePath == AppImage.googleLogoWhite) {
//             await AuthServices.signInWithGoogle(context).then((value) {
//               if (AuthServices.getCurrentUser != null) {
//                 Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
//               }
//             });
//           }
//         },
//         child: CircleAvatar(
//           backgroundImage: AssetImage(imagePath),
//         ),
//       ),
//     );
//   }
// }
