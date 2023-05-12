import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/consts/colors.dart';

class KamaalDropDown extends StatelessWidget {
  final List<String> menuItems;
  final String selectedItem;
  final String icon;
  final void Function(String?)? onChanged;
  const KamaalDropDown(
      {super.key,
      required this.menuItems,
      required this.selectedItem,
      this.icon = "",
      this.onChanged});

  @override
  Widget build(BuildContext context) {
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
            child: icon.isNotEmpty
                ? Image.asset(
                    "assets/icons/$icon.png",
                    height: 16.w,
                    width: 16.w,
                  )
                : const SizedBox(
                    width: 20,
                  ),
          ),
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              minWidth: double.maxFinite,
              alignedDropdown: true,
              child: DropdownButton(
                  isDense: true,
                  alignment: Alignment.center,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  dropdownColor: const Color.fromARGB(255, 237, 246, 237),
                  value: selectedItem,
                  items: menuItems.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: onChanged),
            ),
          ),
        ],
      ),
    );
  }
}
