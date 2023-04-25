import 'package:abhay_chemicals/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController {
  final BuildContext context;
  const AuthController({required this.context});

  // void handleRegistration() async {
  //   try {
  //     final state = context.read<AuthBloc>().state;
  //     String phone = state.phone;
  //     print("${phone} is the phone nunber");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void handleLoginIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<AuthBloc>().state;
        String emailAddress = state.email;
        String userPassword = state.password;

        if (emailAddress.isEmpty) {
          print("email is empty");

          return;
        }
        if (userPassword.isEmpty) {
          print("password is empty");

          return;
        }
        try {
          final creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailAddress, password: userPassword);
          print(creds);

          if (creds.user != null) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          } else if (creds.user == null) {
            print("error from creds.user == null");
            return;
          }
          if (!creds.user!.emailVerified) {
            print("not verified");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            print(e.code);
            return;
          } else if (e.code == "wrong-password") {
            print(e.code);
            return;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
