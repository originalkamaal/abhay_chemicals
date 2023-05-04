import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  DateTime selectedDate = DateTime.now();
  String batchNumber = "";
  bool isNewCustomer = false;
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add New Supplier"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              reusableText("Company or Individual Name", 20.w),
              buildTextInput(
                placeHolder: "Enter Name",
                inputType: "text",
                iconName: "person",
                onChange: ((value) {
                  setState(() {
                    batchNumber = value;
                  });
                }),
              ),
              reusableText("Contact Number", 20.w),
              buildDateInput(
                  onTap: () {
                    _selectDate(context);
                  },
                  placeHolder: "Enter Contact Number",
                  inputType: "mobile",
                  iconName: "ang",
                  controller: controller),
              reusableText("Email", 20.w),
              buildTextInput(
                placeHolder: "Enter Email",
                inputType: "text",
                iconName: "message-circle",
                onChange: ((value) {
                  setState(() {
                    batchNumber = value;
                  });
                }),
              ),
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
                child: filledButton(AppColors.primaryElement, "SUBMIT"),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
