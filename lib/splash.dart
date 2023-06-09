import 'package:abhay_chemicals/screens/home_screen.dart';
import 'package:abhay_chemicals/screens/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  late final User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/logo.png'),
      nextScreen: firebaseUser != null
          ? const HomeScreen()
          : const LoginScreen(), //else LoginScreen
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
