import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProduction extends StatefulWidget {
  const EditProduction({super.key});

  @override
  State<EditProduction> createState() => _EditProductionState();
}

class _EditProductionState extends State<EditProduction> {
  DateTime selectedDate = DateTime.now();
  String batchNumber = "";
  bool batchNumberError = false;
  TextEditingController controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
        initialDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = selectedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add Production"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableText("Batch No", 20.w),
              buildTextInput(
                placeHolder: "Enter Batch Number",
                inputType: "text",
                iconName: "ang",
                onChange: ((value) {
                  setState(() {
                    batchNumber = value;
                  });
                }),
              ),
              Visibility(
                  visible: batchNumberError == true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please fill correct details..",
                      style: TextStyle(color: Colors.red),
                    ),
                  )),
              reusableText("Batch No", 20.w),
              buildDateInput(
                  onTap: () {
                    _selectDate(context);
                  },
                  placeHolder: "Select Date",
                  inputType: "text",
                  iconName: "ang",
                  controller: controller),
              GestureDetector(
                  onTap: () async {
                    if (batchNumber != "" && controller.text != "") {
                      bool status = await ProductionController()
                          .addProduction(controller.text, batchNumber);
                      if (status == true) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: filledButton(AppColors.primaryElement, "SUBMIT")),
            ],
          ),
        ));
  }
}
