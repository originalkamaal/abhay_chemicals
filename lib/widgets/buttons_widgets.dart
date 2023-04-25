import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget filledButton(Color fillColor, title) {
  return Container(
    margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 25.w),
    height: 40.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.w),
      color: fillColor,
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5),
      ),
    ),
  );
}
