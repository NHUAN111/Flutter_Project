import 'package:flutter/material.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/views/Cart/cart_view.dart';
import 'package:project_specialized_1/views/Coupon/coupon_view.dart';
import 'package:project_specialized_1/views/LoginOrRegister/login_view.dart';
import 'package:project_specialized_1/views/LoginOrRegister/register_view.dart';
import 'package:project_specialized_1/views/Order/order_page_view.dart';
import 'package:project_specialized_1/views/Splash/splash_view.dart';
import 'package:project_specialized_1/views/Category/category_view%20.dart';
import 'package:project_specialized_1/views/home_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());

      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterView());

      case RoutesName.category:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CategoriesView());

      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.cart:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartView());

      case RoutesName.coupon:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CouponView());

      case RoutesName.order:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OrderViews());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text("No route defined"),
                  ),
                ));
    }
  }
}
