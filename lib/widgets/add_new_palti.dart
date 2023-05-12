import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPalti extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> e;

  const AddNewPalti({super.key, required this.e});

  @override
  State<AddNewPalti> createState() => _AddNewPaltiState();
}

class _AddNewPaltiState extends State<AddNewPalti> {
  DateTime selectedDate = DateTime.now();
  String temp = "";
  String notes = "";
  String palti = "";
  bool tempError = false;
  bool paltiError = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(DateTime.now().year + 1));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text("Add New Palti Record"),
        ),
        Visibility(
          visible: tempError == true,
          child: Center(
            child: Text(
              "Something Went Wrong..",
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
        ),
        Row(
          children: [
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            TextButton(
                onPressed: () => _selectDate(context),
                child: const Text("Select Date"))
          ],
        ),
        TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "Palti"),
          onChanged: (value) {
            setState(() {
              palti = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Temperature"),
          onChanged: (value) {
            setState(() {
              temp = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "Notes"),
          onChanged: (value) {
            setState(() {
              notes = value;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    palti = "";
                    temp = "";
                    notes = "";
                  });
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  if (palti != "" && temp != "") {
                  } else {
                    setState(() {
                      tempError = true;
                    });
                  }
                },
                child: const Text("Submit"))
          ],
        )
      ],
    ));
  }
}
