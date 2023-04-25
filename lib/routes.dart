import 'package:abhay_chemicals/screens/home_screen.dart';
import 'package:abhay_chemicals/splash.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
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
