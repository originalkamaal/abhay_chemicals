import 'package:abhay_chemicals/screens/customers/customers_screen.dart';
import 'package:abhay_chemicals/screens/home_screen.dart';
import 'package:abhay_chemicals/screens/login_screen.dart';
import 'package:abhay_chemicals/screens/production/add_production.dart';
import 'package:abhay_chemicals/screens/suppliers/suppliers_screen.dart';
import 'package:abhay_chemicals/screens/users/users_screen.dart';
import 'package:abhay_chemicals/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return _buildRoute(routeSettings, SplashScreen());
      case '/signin':
        return _buildRoute(routeSettings, const LoginScreen());
      case '/home':
        return _buildRoute(routeSettings, const HomeScreen());
      case '/customers':
        return _buildRoute(routeSettings, const Customers());
      case '/suppliers':
        return _buildRoute(routeSettings, const Suppliers());
      case '/users':
        return _buildRoute(routeSettings, const Users());
      case '/addProductions':
        return _buildRoute(routeSettings, const EditProduction());
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
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
