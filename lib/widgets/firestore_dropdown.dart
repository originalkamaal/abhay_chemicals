import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FireStoreDropdown extends StatefulWidget {
  final String collection;
  final String field;
  final String? selectedValue;
  final void Function(dynamic)? onChanged;
  const FireStoreDropdown(
      {super.key,
      required this.collection,
      required this.field,
      this.selectedValue,
      required this.onChanged});

  @override
  State<FireStoreDropdown> createState() => _FireStoreDropdownState();
}

class _FireStoreDropdownState extends State<FireStoreDropdown> {
  String selectedSuplier = "0";
  List<DropdownMenuItem> careofsItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedValue != null) {
      selectedSuplier = widget.selectedValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.collection)
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final careofs = snapShot.data!.docs.toList();
            careofsItems.clear();
            careofsItems.add(
              DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: "0",
                child: Text(
                  "Select One",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            );
            for (DocumentSnapshot careof in careofs) {
              careofsItems.add(DropdownMenuItem(
                value: careof[widget.field],
                child: Text(
                  careof[widget.field],
                  style: TextStyle(fontSize: 12.sp),
                ),
              ));
            }
          }

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
                  selectedSuplier = value;
                });
                widget.onChanged!(value);
              },
              items: careofsItems,
            )),
          );
        });
  }
}
