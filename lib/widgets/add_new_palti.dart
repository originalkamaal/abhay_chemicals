import 'package:abhay_chemicals/controllers/production_controller.dart';
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
        Center(
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
          decoration: InputDecoration(hintText: "Palti"),
          onChanged: (value) {
            setState(() {
              palti = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Temperature"),
          onChanged: (value) {
            setState(() {
              temp = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: "Notes"),
          onChanged: (value) {
            setState(() {
              notes = value;
            });
          },
        ),
        SizedBox(
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
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  if (palti != "" && temp != "") {
                    bool status = await ProductionController().addNewPalti(
                        widget.e.reference,
                        selectedDate.toString().split(' ')[0],
                        palti,
                        int.parse(temp),
                        notes);
                    if (status = true) {
                      Navigator.pop(context);
                    }
                  } else {
                    setState(() {
                      tempError = true;
                    });
                  }
                },
                child: Text("Submit"))
          ],
        )
      ],
    ));
  }
}
