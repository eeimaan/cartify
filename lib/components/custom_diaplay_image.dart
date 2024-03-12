// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/constants.dart';

// class CustomDisplayImage extends StatelessWidget {
//   final String imageUrl;
//   final double? width;
//   final bool isOpenForMsg;
//   final double? height;

//   const CustomDisplayImage({
//     super.key,
//     required this.imageUrl,
//     this.isOpenForMsg = false,
//     this.width = 40,
//     this.height = 40,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: height,
//         width: width,
//         decoration: isOpenForMsg
//             ? BoxDecoration(borderRadius: BorderRadius.circular(12))
//             : const BoxDecoration(
//                 shape: BoxShape.circle,
//               ),
//         alignment: Alignment.center,
//         clipBehavior: Clip.hardEdge,
//         child: imageUrl != ''
//             ? CachedNetworkImage(
//                 key: ValueKey(imageUrl),
//                 useOldImageOnUrlChange: true,
//                 imageUrl: imageUrl,
//                 fit: BoxFit.fill,
//                 width: width,
//                 height: height,
//                 placeholder: (context, url) =>
//                     const CupertinoActivityIndicator(),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               )
//             : const Image(image: AssetImage(AppImage.jones)));
//   }
// }
