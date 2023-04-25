import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 135, 205, 100),
          padding: EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryElement,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Text(
                      user!.email![0].toUpperCase() ?? "0",
                      style: TextStyle(fontSize: 24.sp, color: Colors.white),
                    )),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 150.w,
                        child: Text(
                          user!.email ?? "",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 150.w,
                        child: Text(
                          user!.displayName == ""
                              ? "Admin"
                              : user!.displayName ?? "Admin",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
