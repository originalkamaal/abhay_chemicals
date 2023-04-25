import 'package:abhay_chemicals/firebase_options.dart';
import 'package:abhay_chemicals/routes.dart';
import 'package:abhay_chemicals/bloc_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
              fontFamily: "Montserrat",
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent))),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: MyRoutes.generateRoutes,
        ),
      ),
    );
  }
}
