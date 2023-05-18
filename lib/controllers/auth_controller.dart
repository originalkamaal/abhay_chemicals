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

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) =>
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/signin", (route) => false));
    } catch (e) {
      // do something with errr
    }
  }

  Future<void> handleLoginIn(String type, String email, String password) async {
    try {
      if (type == "email") {
        final state = context.read<AuthBloc>().state;

        if (email.isEmpty) {
          throw Exception("Email is required");
        }
        if (password.isEmpty) {
          throw Exception("Password is required");
        }
        try {
          final creds = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          if (creds.user != null) {
            if (context.mounted) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            } else {}
          } else if (creds.user == null) {
            throw Exception("Something went wrong");
          }
          if (!creds.user!.emailVerified) {}
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            throw Exception("User not found");
          } else if (e.code == "wrong-password") {
            throw Exception("Invalid credentials");
          }
        }
      } else {
        throw Exception("Email is required");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Something went wrong");
    }
  }
}
