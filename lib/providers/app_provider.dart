import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:provider/provider.dart';

class CartifyApp extends StatefulWidget {
  const CartifyApp({super.key});

  @override
  State<CartifyApp> createState() => _CartifyAppState();
}

class _CartifyAppState extends State<CartifyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
        ChangeNotifierProvider<CartCountProvider>(
          create: (context) => CartCountProvider(),
        ),
        ChangeNotifierProvider<CartPriceProvider>(
          create: (context) => CartPriceProvider(),
        ),
        ChangeNotifierProvider<CounterProvider>(
          create: (context) => CounterProvider(),
        ),
        
        ChangeNotifierProvider<FavProvider>(
          create: (context) => FavProvider(),
        ),
        ChangeNotifierProvider<ThemeManager>(
          create: (context) => ThemeManager(),
        ),
        ChangeNotifierProvider<PaymentProvider>(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (context) => ReviewProvider(),
        ),
        ChangeNotifierProvider<AddressProvider>(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (context) => ImagePickerProvider(),
        ),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              canvasColor: AppColors.colorWhite,
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                color: AppColors.colorWhite,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              scaffoldBackgroundColor: AppColors.colorWhite,
              primaryColor: AppColors.colorWhite,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  color: Colors.black,
                ),
                bodySmall: TextStyle(color: AppColors.colorLightText),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              canvasColor: Colors.black,
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                color: Colors.black,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: AppColors.colorWhite,
              ),
              scaffoldBackgroundColor: Colors.black,
              primaryColor: Colors.black,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  color: AppColors.colorWhite,
                ),
              ),
            ),
            themeMode: themeManager.themeMode,
            onGenerateRoute: Routers.generateRoute,
          );
        },
      ),
    );
  }
}
