// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/utils.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class ConnectionChecker {
//   late StreamSubscription subscription;
//   bool isDeviceConnected = false;
//   bool isAlertSet = false;
//   late BuildContext context;

 

//   void getConnectivity() {
//     subscription = Connectivity().onConnectivityChanged.listen(
//       (ConnectivityResult result) async {
//         isDeviceConnected = await InternetConnectionChecker().hasConnection;
//         if (!isDeviceConnected && !isAlertSet) {
//           // ignore: use_build_context_synchronously
//           SnackbarHelper.showSnackbar(context, 'Please select options');
//           isAlertSet = true;
//         } else if (isDeviceConnected && isAlertSet) {
//           isAlertSet = false;
//         }
//       },
//     );
//   }

//   void dispose() {
//     subscription.cancel();
//   }
// }
