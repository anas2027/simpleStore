import 'package:flutter/material.dart';

import '../../features/cart/view/cart_page.dart';
import '../../features/main/view/main_page.dart';
import '../../features/products/view/product_details_page.dart';
import '../../features/splash/view/splash_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const String root = '/';
  static const String main = '/main';
  static const String splash = '/splash';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
      case splash:
        return MaterialPageRoute<void>(builder: (_) => const SplashPage());
      case productDetails:
        final productId = settings.arguments as int;
        return MaterialPageRoute<void>(
          builder: (_) => ProductDetailsPage(productId: productId),
        );
      case cart:
        return MaterialPageRoute<void>(builder: (_) => const CartPage());
      case main:
        return MaterialPageRoute<void>(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute<void>(builder: (_) => const MainPage());
    }
  }
}
