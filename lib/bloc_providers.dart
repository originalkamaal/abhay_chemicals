import 'package:abhay_chemicals/blocs/auth_bloc/auth_bloc.dart';
import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CommonBloc())
      ];
}
