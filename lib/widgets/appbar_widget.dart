import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // bottom: PreferredSize(
    //   preferredSize: const Size.fromHeight(1.0),
    //   child: Container(
    //     color: Colors.grey.withOpacity(0.8),
    //     height: 1.0,
    //   ),
    // ),
    title: Text(
      title,
      style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal),
    ),
  );
}
