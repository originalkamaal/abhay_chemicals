import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/orders_controller.dart';
import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/firestore_dropdown.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:abhay_chemicals/widgets/static_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDirectSales extends StatefulWidget {
  final DocumentSnapshot? document;
  const AddDirectSales({super.key, this.document});

  @override
  State<AddDirectSales> createState() => _AddDirectSalesState();
}

class _AddDirectSalesState extends State<AddDirectSales> {
  List<String> items = [
    "Aarsh Jaivik",
    "Bio Combi",
    "Bio Starter",
    "Humic",
    "Gut-clean",
    "AB Hy-Groth",
    "AB Aqua Clean",
    "AB Soil Care"
  ];
  DateTime selectedDate = DateTime.now();
  String challanNo = "";
  String customer = "";
  String careof = "";
  String fullFilled = "";
  String item = "";
  String quantity = "";
  String village = "";

  String challanNoErr = "";
  String dateErr = "";
  String customerErr = "";
  String careofErr = "";
  String itemErr = "";
  String quantityErr = "";
  String villageErr = "";
  TextEditingController controller = TextEditingController();

  validation() {
    bool status = true;
    if (challanNo == "") {
      status = false;
      setState(() {
        challanNoErr = "Please enter challan number";
      });
    }
    if (controller.text == "") {
      status = false;
      setState(() {
        dateErr = "Please select date.";
      });
    }

    if (customer == "") {
      status = false;
      setState(() {
        customerErr = "Please select customer.";
      });
    }

    if (careof == "") {
      status = false;
      setState(() {
        careofErr = "Please select careof";
      });
    }

    if (village == "") {
      status = false;
      setState(() {
        villageErr = "Please select careof";
      });
    }

    if (item == "") {
      status = false;
      setState(() {
        itemErr = "Please select Item.";
      });
    }

    if (quantity == "") {
      status = false;
      setState(() {
        quantityErr = "Please enter quantity";
      });
    }
    return status;
  }

  @override
  initState() {
    super.initState();
    if (widget.document != null) {
      challanNo = widget.document!['challanNumber'].toString();
      customer = widget.document!['customer'];
      controller.text = widget.document!['date'];
      careof = (widget.document!['careOf']);

      item = widget.document!['item'].toString();
      quantity = widget.document!['quantity'].toString();
      village = widget.document!['village'];
    }
  }

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
        appBar: buildAppBar("Add New Sales"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              reusableText("Challan No", 20.w),
              buildTextInput(
                placeHolder: "Enter Order Id",
                inputType: "number",
                iconName: "ang",
                initialValue: challanNo,
                onChange: ((value) {
                  setState(() {
                    challanNo = value;
                  });
                }),
              ),
              ErrorText(nameErr: challanNoErr),
              reusableText("Date", 10.w),
              buildDateInput(
                  onTap: () {
                    _selectDate(context);
                  },
                  placeHolder: "Select Date",
                  inputType: "text",
                  iconName: "ang",
                  controller: controller),
              ErrorText(nameErr: dateErr),
              reusableText("Customer", 20.w),
              FireStoreDropdown(
                  collection: "customer",
                  field: "name",
                  selectedValue: customer,
                  onChanged: (value) {
                    setState(() {
                      customer = value;
                    });
                  }),
              ErrorText(nameErr: customerErr),
              reusableText("Care Of", 20.w),
              FireStoreDropdown(
                  collection: "careof",
                  field: "name",
                  selectedValue: careof,
                  isRef: false,
                  onChanged: (value) {
                    setState(() {
                      careof = value;
                    });
                  }),
              ErrorText(nameErr: careofErr),
              reusableText("Village", 20.w),
              buildTextInput(
                placeHolder: "Enter Village",
                inputType: "text",
                iconName: "ang",
                initialValue: village,
                onChange: ((value) {
                  setState(() {
                    village = value;
                  });
                }),
              ),
              ErrorText(nameErr: villageErr),
              reusableText("Item", 20.w),
              StaticDropDown(
                  itemsList: items,
                  selectedItem: item == "" ? "Select One" : item,
                  onChanged: (value) {
                    setState(() {
                      item = value;
                    });
                  }),
              ErrorText(nameErr: itemErr),
              reusableText("Quantity", 20.w),
              buildTextInput(
                placeHolder: "Enter Quantity",
                inputType: "number",
                initialValue: quantity,
                iconName: "ang",
                onChange: ((value) {
                  setState(() {
                    quantity = value;
                  });
                }),
              ),
              ErrorText(nameErr: quantityErr),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    challanNoErr = "";
                    dateErr = "";
                    customerErr = "";
                    careofErr = "";
                    itemErr = "";
                    quantityErr = "";
                    villageErr = "";
                  });
                  if (validation()) {
                    bool status = await OrderSalesController.addDirectSales(
                      careof: careof,
                      challanNo: challanNo,
                      customer: customer,
                      date: controller.text,
                      item: item,
                      quantity: quantity,
                      fullFilled: quantity,
                      village: village,
                      orderId: "0",
                    );
                    if (status) {
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
