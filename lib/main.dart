//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/app_provider.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:device_preview/device_preview.dart';
 
late SharedPreferences pref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  pref = await SharedPreferences.getInstance();

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;


  Stripe.publishableKey = AppText.stripePublishKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(
      DevicePreview(builder: (context) =>
      const CartifyApp()
    )
      );
}
