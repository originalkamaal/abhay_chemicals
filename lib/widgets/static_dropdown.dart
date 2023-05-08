import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaticDropDown extends StatefulWidget {
  final List<String> itemsList;
  final String? selectedItem;
  final void Function(dynamic)? onChanged;
  const StaticDropDown(
      {super.key,
      required this.itemsList,
      this.selectedItem,
      required this.onChanged});

  @override
  State<StaticDropDown> createState() => _StaticDropDownState();
}

class _StaticDropDownState extends State<StaticDropDown> {
  String selectedSuplier = "Select One";
  List<String> items = ["Select One"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedItem != "") {
      selectedSuplier = widget.selectedItem!;
    }
    items.addAll(widget.itemsList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(color: AppColors.primaryThreeElementText)),
      width: double.maxFinite,
      height: 50.w,
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        isExpanded: true,
        value: selectedSuplier,
        onChanged: (value) {
          setState(() {
            selectedSuplier = value as String;
          });
          widget.onChanged!(value);
        },
        items: items.map((e) {
          return DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: e,
            child: Text(
              e,
              style: TextStyle(fontSize: 12.sp),
            ),
          );
        }).toList(),
      )),
    );
  }
}
