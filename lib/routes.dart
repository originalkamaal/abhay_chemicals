import 'package:abhay_chemicals/screens/customers/customers_screen.dart';
import 'package:abhay_chemicals/screens/home_screen.dart';
import 'package:abhay_chemicals/screens/login_screen.dart';
import 'package:abhay_chemicals/screens/suppliers/suppliers_screen.dart';
import 'package:abhay_chemicals/screens/users/users_screen.dart';
import 'package:abhay_chemicals/splash.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/signin':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/customers':
        return MaterialPageRoute(builder: (context) => const Customers());
      case '/suppliers':
        return MaterialPageRoute(builder: (context) => const Suppliers());
      case '/users':
        return MaterialPageRoute(builder: (context) => const Users());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error 404')),
        ),
      );
    });
  }
}
