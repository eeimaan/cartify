import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/screens/screens.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return animatePage(_getPage(settings));
  }

  static Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.startPage:
        return const StartPage();

      case AppRoutes.createAccount:
        return const CreateAccountPage();

      case AppRoutes.loginScreen:
        return const LoginScreen();

      case AppRoutes.showProfile:
       return const ProfilePage();
     
      case AppRoutes.ecommercePage:
        return const EcommercePage();
      case AppRoutes.ecommerceFavoritePage:
        return const EcommerceFavoritePage();
      case AppRoutes.ecommerceCheckoutPage:
        return const EcommerceCheckoutPage();
      case AppRoutes.viewOrder:
        final dynamic arguments = settings.arguments;

        return ViewOrder(
          orderData: arguments["products"],
          status: arguments["status"],
        );
      case AppRoutes.ecommercePaymentMethodPage:
        return const EcommercePaymentMethodPage();
      case AppRoutes.ecommerceAddressesPage:
        return const EcommerceAddressesPage();
      // case AppRoutes.ecommerceNewCardPage:
      //   return const EcommerceNewCardPage();
      case AppRoutes.ecommerceOrderPage:
        return const EcommerceOrderPage();
      case AppRoutes.ecommerceOrderDetailPage:
        final dynamic arguments = settings.arguments;
        return EcommerceOrderDetailPage(
          price: arguments['price'],
          image: arguments['image'],
          name: arguments['name'],
          quantity: arguments['quantity'],
        );
      case AppRoutes.ecommerceProductPage:
        final dynamic arguments = settings.arguments;
        return EcommerceProductPage(
          productData: arguments,
        );
      case AppRoutes.ecommerceCartPage:
        return const EcommerceCartPage();
      case AppRoutes.ecommerceEreceiptPage:
        return const EcommerceEreceiptPage();
      case AppRoutes.ecommerceReviewPage:
        final dynamic arguments = settings.arguments;
        return EcommerceReviewPage(
          productId: arguments['product_id'],
        );

      default:
        return const StatusScreen();
    }
  }

  static PageRouteBuilder animatePage(Widget widget) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => widget,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return customLeftSlideTransition(animation, child);
      },
    );
  }

  static Widget customLeftSlideTransition(
      Animation<double> animation, Widget child) {
    Tween<Offset> tween =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
    return SlideTransition(
      position: tween.animate(animation),
      child: child,
    );
  }
}
