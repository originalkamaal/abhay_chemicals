import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FireStoreDropdown extends StatefulWidget {
  final String collection;
  final String field;
  final String? selectedValue;
  final bool isRef;
  final void Function(dynamic)? onChanged;
  const FireStoreDropdown(
      {super.key,
      required this.collection,
      required this.field,
      this.isRef = false,
      this.selectedValue,
      required this.onChanged});

  @override
  State<FireStoreDropdown> createState() => _FireStoreDropdownState();
}

class _FireStoreDropdownState extends State<FireStoreDropdown> {
  bool careOfExists = false;
  String selectedSuplier = "0";
  late List<DropdownMenuItem> careofsItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedValue != null) {
      selectedSuplier = widget.selectedValue!.toString();
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
            final careofs = snapShot.data!.docs.toSet().toList();

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
            Set<String> seen = {};
            for (DocumentSnapshot careof in careofs) {
              if (seen.contains(widget.isRef
                  ? careof.reference.path
                  : careof[widget.field])) {
              } else {
                careofsItems.add(DropdownMenuItem(
                  value: widget.isRef
                      ? careof.reference.path
                      : careof[widget.field],
                  child: Text(
                    careof[widget.field],
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ));
                seen.add(widget.isRef
                    ? careof.reference.path
                    : careof[widget.field]);
              }
            }
          }

          for (var e in careofsItems) {
            if (selectedSuplier == e.value) {
              careOfExists = true;
              continue;
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
              value: careOfExists == true ? selectedSuplier : "0",
              onChanged: (value) {
                setState(() {
                  selectedSuplier = value!.toString();
                });
                if (widget.isRef == true) {
                  for (var e in snapShot.data!.docs) {
                    if (e.reference.path == value) {
                      widget.onChanged!(e['name']);
                    }
                  }
                } else {
                  widget.onChanged!(value);
                }
              },
              items: careofsItems,
            )),
          );
        });
  }
}
