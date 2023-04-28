import 'package:abhay_chemicals/blocs/auth_bloc/auth_bloc.dart';
import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/blocs/purchase_bloc/purchase_bloc.dart';
import 'package:abhay_chemicals/blocs/sales_bloc/sales_bloc.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                SalesBloc(salesControler: SalesController())..add(LoadSales())),
        BlocProvider(
            create: (_) => PurchaseBloc(purchaseControler: PurchaseController())
              ..add(LoadPurchase()))
      ];
}
