import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/consts/colors.dart';

class KamaalDropDownTwo extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final String selectedItem;
  final String icon;
  final void Function(Object?)? onChanged;
  const KamaalDropDownTwo(
      {super.key,
      required this.menuItems,
      required this.selectedItem,
      this.icon = "",
      this.onChanged});

  @override
  State<KamaalDropDownTwo> createState() => _KamaalDropDownTwoState();
}

class _KamaalDropDownTwoState extends State<KamaalDropDownTwo> {
  List<Map<String, dynamic>> menuItemsTwo = [];

  @override
  void initState() {
    super.initState();
    menuItemsTwo = widget.menuItems;
  }

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
            child: widget.icon.isNotEmpty
                ? Image.asset(
                    "assets/icons/${widget.icon}.png",
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
                  value: widget.selectedItem,
                  alignment: Alignment.center,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  dropdownColor: const Color.fromARGB(255, 237, 246, 237),
                  items: menuItemsTwo.map((item) {
                    return DropdownMenuItem(
                      value: item['value'],
                      child: Text(item['title']),
                    );
                  }).toList(),
                  onChanged: widget.onChanged),
            ),
          ),
        ],
      ),
    );
  }
}
