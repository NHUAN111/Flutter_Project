import 'package:flutter/material.dart';
import 'package:project_specialized_1/utils/routes/routes_name.dart';
import 'package:project_specialized_1/view/LoginOrRegister/login_view.dart';
import 'package:project_specialized_1/view/LoginOrRegister/register_view.dart';
import 'package:project_specialized_1/view/Splash/splash_view.dart';
import 'package:project_specialized_1/view/Category/category_view%20.dart';
import 'package:project_specialized_1/view/home_view.dart';

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
