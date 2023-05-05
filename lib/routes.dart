import 'package:abhay_chemicals/screens/customers/add_customer.dart';
import 'package:abhay_chemicals/screens/customers/customers_screen.dart';
import 'package:abhay_chemicals/screens/customers/edit_customer.dart';
import 'package:abhay_chemicals/screens/expense/add_expenses.dart';
import 'package:abhay_chemicals/screens/expense/edit_expenses.dart';
import 'package:abhay_chemicals/screens/home_screen.dart';
import 'package:abhay_chemicals/screens/login_screen.dart';
import 'package:abhay_chemicals/screens/production/add_production.dart';
import 'package:abhay_chemicals/screens/purchase/add_purchase.dart';
import 'package:abhay_chemicals/screens/purchase/purchase.dart';
import 'package:abhay_chemicals/screens/sales/add_order.dart';
import 'package:abhay_chemicals/screens/sales/add_sales.dart';
import 'package:abhay_chemicals/screens/suppliers/add_suppliers.dart';
import 'package:abhay_chemicals/screens/suppliers/edit_supplier.dart';
import 'package:abhay_chemicals/screens/suppliers/suppliers_screen.dart';
import 'package:abhay_chemicals/screens/users/add_admin.dart';
import 'package:abhay_chemicals/screens/users/add_careof.dart';
import 'package:abhay_chemicals/screens/users/edit_admin.dart';
import 'package:abhay_chemicals/screens/users/edit_careof.dart';
import 'package:abhay_chemicals/screens/users/users_careof.dart';
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
      case '/addOrders':
        return _buildRoute(routeSettings, const AddOrder());
      case '/addSales':
        return _buildRoute(routeSettings, const AddSales());
      case '/addSupplier':
        return _buildRoute(routeSettings, const AddSupplier());
      case '/addAdmin':
        return _buildRoute(routeSettings, const AddAdmin());
      case '/addCareOf':
        return _buildRoute(routeSettings, const AddCareOf());
      case '/editCareOf':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, EditCareOf(document: e));
      case '/editAdmin':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, EditAdmin(document: e));
      case '/editSupplier':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, EditSupplier(document: e));
      case '/editCustomer':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, EditCustomer(documentSnapshot: e));
      case '/editExpense':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, EditExpense(document: e));
      case '/editPurchase':
        DocumentSnapshot e = (routeSettings.arguments as DocumentSnapshot);
        return _buildRoute(routeSettings, AddNewPurchase(documentSnapshot: e));
      case '/addCustomer':
        return _buildRoute(routeSettings, const AddCustomer());
      case '/addExpense':
        return _buildRoute(routeSettings, const AddExpense());
      case '/addPurchase':
        return _buildRoute(routeSettings, const AddNewPurchase());
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
