import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add New Order"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              reusableText("Order Id", 20.w),
              buildTextInput(
                placeHolder: "Enter Batch Number",
                inputType: "number",
                iconName: "ang",
                onChange: ((value) {
                  setState(() {
                    batchNumber = value;
                  });
                }),
              ),
              reusableText("Date", 10.w),
              buildDateInput(
                  onTap: () {
                    _selectDate(context);
                  },
                  placeHolder: "Select Date",
                  inputType: "text",
                  iconName: "ang",
                  controller: controller),
              reusableText("Customer", 20.w),
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
              reusableText("Care Of", 20.w),
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
              reusableText("Product", 20.w),
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
              reusableText("Quantity", 20.w),
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
            ],
          ),
        ));
  }
}
