import 'package:abhay_chemicals/blocs/auth_bloc/auth_bloc.dart';
import 'package:abhay_chemicals/controllers/firebase.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/consts/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: true,
          appBar: buildAppBar("Login to Dashboard"),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 150.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(right: 25.w, left: 25.w, top: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Email", 20.w),
                          buildTextInput(
                              placeHolder: "Enter your email address",
                              inputType: "email",
                              iconName: "user",
                              onChange: (value) => context
                                  .read<AuthBloc>()
                                  .add(LoginEmailEvent(value))),
                          reusableText("Password", 20.w),
                          buildTextInput(
                              placeHolder: "Enter Password",
                              inputType: "password",
                              iconName: "lock",
                              onChange: (value) => context
                                  .read<AuthBloc>()
                                  .add(LoginPasswordEvent(value))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 25.w, top: 10.w),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgotPass');
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: AppColors.primaryText,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryText,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthController(context: context).handleLoginIn("email");
                      },
                      child: filledButton(AppColors.primaryElement, "LOGIN"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
