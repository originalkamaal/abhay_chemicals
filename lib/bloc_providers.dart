//Blocs
import 'package:abhay_chemicals/blocs/sales_bloc/sales_bloc.dart';
import 'package:abhay_chemicals/blocs/suppliers_bloc/suppliers_bloc.dart';
import 'package:abhay_chemicals/blocs/user_bloc/user_bloc.dart';
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
                  ..add(LoadProductions())),
        BlocProvider(
            create: (_) =>
                CustomersBloc(customersController: CustomersController())
                  ..add(LoadCustomers())),
        BlocProvider(
            create: (_) =>
                SaleBloc(saleController: SalesController())..add(LoadSales())),
        BlocProvider(
            create: (_) =>
                PurchaseBloc(purchaseController: PurchaseController())
                  ..add(LoadPurchases())),
        BlocProvider(
            create: (_) => ExpenseBloc(expenseController: ExpenseController())
              ..add(LoadExpense())),
        BlocProvider(
            create: (_) =>
                SuppliersBloc(supplierController: SupplierController())
                  ..add(LoadSuppliers())),
        BlocProvider(
            create: (_) =>
                UsersBloc(usersController: UsersController())..add(LoadUsers()))
      ];
}
