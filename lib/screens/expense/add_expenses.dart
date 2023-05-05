import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/expense_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime selectedDate = DateTime.now();
  String amount = "";
  String description = "";
  String amountErr = "";
  String descriptionErr = "";
  String mainErr = "";
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

  bool validation() {
    bool result = true;
    if (amount == "") {
      setState(() {
        amountErr = "Please enter amount";
        result = false;
      });
    }

    if (controller.text == "") {
      setState(() {
        mainErr = "date must be selected";
        result = false;
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add Expense"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              ErrorText(nameErr: mainErr),
              reusableText("Amount", 20.w),
              buildTextInput(
                placeHolder: "Enter Amount",
                inputType: "number",
                iconName: "ang",
                onChange: ((value) {
                  setState(() {
                    amount = value;
                  });
                }),
              ),
              ErrorText(nameErr: amountErr),
              reusableText("Date", 10.w),
              buildDateInput(
                  onTap: () {
                    _selectDate(context);
                  },
                  placeHolder: "Select Date",
                  inputType: "text",
                  iconName: "ang",
                  controller: controller),
              reusableText("Description", 20.w),
              buildTextInput(
                placeHolder: "Enter Description",
                inputType: "text",
                iconName: "ang",
                onChange: ((value) {
                  setState(() {
                    description = value;
                  });
                }),
              ),
              GestureDetector(
                onTap: () async {
                  if (validation()) {
                    bool status = await ExpenseController().addExpense(
                        date: controller.text,
                        amount: amount,
                        description: description);
                    if (status == true) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        mainErr = "something went wrong";
                      });
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
