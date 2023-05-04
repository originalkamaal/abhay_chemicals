import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: 10.h,
    ),
    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     _reusableIcons("google", ""),
    //     _reusableIcons("apple", ""),
    //     _reusableIcons("facebook", ""),
    //   ],
    // ),

    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _reusableIcons("google", ""),
          _reusableIcons("apple", ""),
          _reusableIcons("facebook", ""),
        ],
      ),
    ),
  );
}

Widget _reusableIcons(String iconPath, String? routeName) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Image.asset("assets/icons/$iconPath.png"),
      ),
    ),
  );
}

Widget reusableText(String text, double topPadding) {
  return Container(
    padding: EdgeInsets.only(top: topPadding),
    margin: EdgeInsets.only(bottom: 4.h),
    child: Text(
      text,
      style: TextStyle(
          color: AppColors.primaryThreeElementText,
          fontWeight: FontWeight.normal,
          fontSize: 11.sp),
    ),
  );
}

Widget buildDateInput(
    {String placeHolder = "",
    String inputType = "",
    String iconName = "",
    void Function()? onTap,
    TextEditingController? controller}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(color: AppColors.primaryThreeElementText)),
        width: double.maxFinite,
        height: 50.w,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 17.w),
              child: inputType == "mobile"
                  ? const Text("+91")
                  : Image.asset(
                      "assets/icons/$iconName.png",
                      height: 16.w,
                      width: 16.w,
                    ),
            ),
            Expanded(
              child: TextFormField(
                enabled: false,
                controller: controller,
                obscureText: inputType == "password" ? true : false,
                keyboardType: inputType == "mobile"
                    ? TextInputType.phone
                    : TextInputType.name,
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                    height: 1.5.w),
                decoration: InputDecoration(
                  hintText: placeHolder,
                  contentPadding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: TextStyle(
                      height: 1.5.w,
                      color: AppColors.primarySecondaryElementText),
                ),
              ),
            ),
          ],
        )),
  );
}

Widget buildTextInput(
    {String placeHolder = "",
    String initialValue = "",
    String inputType = "",
    String iconName = "",
    void Function(String value)? onChange,
    TextEditingController? controller}) {
  return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(color: AppColors.primaryThreeElementText)),
      width: double.maxFinite,
      height: 50.w,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 17.w),
            child: inputType == "mobile"
                ? const Text("+91")
                : Image.asset(
                    "assets/icons/$iconName.png",
                    height: 16.w,
                    width: 16.w,
                  ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              initialValue: initialValue,
              onChanged: onChange,
              obscureText: inputType == "password" ? true : false,
              keyboardType: inputType == "mobile"
                  ? TextInputType.phone
                  : inputType == "number"
                      ? TextInputType.number
                      : TextInputType.name,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                  height: 1.5.w),
              decoration: InputDecoration(
                hintText: placeHolder,
                contentPadding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                hintStyle: TextStyle(
                    height: 1.5.w,
                    color: AppColors.primarySecondaryElementText),
              ),
            ),
          ),
        ],
      ));
}

Widget buildPasswordInput(String placeHolder, String iconName,
    void Function(String value)? onChange) {
  return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(color: AppColors.primaryThreeElementText)),
      width: double.maxFinite,
      height: 50.w,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 17.w),
            child: Image.asset(
              "assets/icons/$iconName.png",
              height: 16.w,
              width: 16.w,
            ),
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChange,
              obscureText: true,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                  height: 1.5.w),
              decoration: InputDecoration(
                hintText: placeHolder,
                contentPadding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                hintStyle: TextStyle(
                    height: 1.5.w,
                    color: AppColors.primarySecondaryElementText),
              ),
            ),
          ),
        ],
      ));
}

Widget inputErrorWidget({List<String> error = const [], bool visible = false}) {
  return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Column(
            children: List.generate(
                error.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "-> ${error[index]}",
                        style: TextStyle(
                            color: Colors.red.withOpacity(0.7),
                            fontSize: 10.sp),
                      ),
                    )).toList()),
      ));
}
