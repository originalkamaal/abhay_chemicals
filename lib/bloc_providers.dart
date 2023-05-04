//Blocs
import 'package:abhay_chemicals/blocs/careof_bloc.dart/careof_bloc.dart';
import 'package:abhay_chemicals/blocs/order_bloc/order_bloc.dart';
import 'package:abhay_chemicals/blocs/ordersales_bloc/ordersales_bloc.dart';
import 'package:abhay_chemicals/blocs/suppliers_bloc/suppliers_bloc.dart';
import 'package:abhay_chemicals/blocs/user_bloc/user_bloc.dart';
import 'package:abhay_chemicals/controllers/careof_controller.dart';
import 'package:abhay_chemicals/controllers/orders_controller.dart';
import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:abhay_chemicals/controllers/supplier_controller.dart';
import 'package:abhay_chemicals/controllers/users_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abhay_chemicals/blocs/auth_bloc/auth_bloc.dart';
import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/customers_bloc/customers_bloc.dart';
import 'package:abhay_chemicals/blocs/expense_bloc/expense_bloc.dart';
import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/blocs/purchase_bloc/purchase_bloc.dart';

//Controllers
import 'package:abhay_chemicals/controllers/customers_controllers.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/controllers/expense_controller.dart';
import 'package:abhay_chemicals/controllers/sales_controller.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CommonBloc()),
        BlocProvider(
            create: (_) =>
                ProductionBloc(productionController: ProductionController())
                  ..add(const LoadProductions())),
        BlocProvider(
            create: (_) =>
                CustomersBloc(customersController: CustomersController())
                  ..add(const LoadCustomers())),
        BlocProvider(
            create: (_) =>
                OrderSaleBloc(orderSaleController: OrderSalesController())
                  ..add(const LoadOrderSales())),
        BlocProvider(
            create: (_) => OrderBloc(orderController: OrdersController())
              ..add(const LoadOrders())),
        BlocProvider(
            create: (_) =>
                PurchaseBloc(purchaseController: PurchaseController())
                  ..add(const LoadPurchases())),
        BlocProvider(
            create: (_) => ExpenseBloc(expenseController: ExpenseController())
              ..add(const LoadExpense())),
        BlocProvider(
            create: (_) =>
                SuppliersBloc(supplierController: SupplierController())
                  ..add(const LoadSuppliers())),
        BlocProvider(
            create: (_) => UsersBloc(usersController: UsersController())
              ..add(const LoadUsers())),
        BlocProvider(
            create: (_) =>
                UsersCareofBloc(usersCareofController: UsersCareofController())
                  ..add(const LoadUsersCareof()))
      ];
}
