import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/firestore_dropdown.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPurchase extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
  const AddNewPurchase({super.key, this.documentSnapshot});

  @override
  State<AddNewPurchase> createState() => _AddNewPurchaseState();
}

class _AddNewPurchaseState extends State<AddNewPurchase> {
  TextEditingController controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool editmode = false;

  String selectedSuplier = "0";
  String selectedBatch = "0";
  String truckNo = "";
  String gateNo = "";
  String item = "";
  String quantity = "";

  String mainErr = "";
  String batchErr = "";
  String supplierErr = "";
  String dateErr = "";
  String gateErr = "";
  String truckErr = "";
  String itemErr = "";
  String quantityErr = "";

  @override
  void initState() {
    super.initState();
    if (widget.documentSnapshot != null) {
      editmode = true;
      selectedSuplier = widget.documentSnapshot!["supplier"].toString();
      selectedBatch = widget.documentSnapshot!["batchNumber"].toString();
      controller.text = widget.documentSnapshot!["date"].toString();
      truckNo = widget.documentSnapshot!["truckNumber"].toString();
      gateNo = widget.documentSnapshot!["gateNumber"].toString();
      item = widget.documentSnapshot!["item"].toString();
      quantity = widget.documentSnapshot!["quantity"].toString();
    }
  }

  bool validation() {
    bool status = true;
    if (selectedBatch == "0") {
      setState(() {
        batchErr = "Please select batch";
        status = false;
      });
    }

    if (selectedSuplier == "0") {
      setState(() {
        supplierErr = "Please select supplier";
        status = false;
      });
    }
    if (controller.text == "") {
      setState(() {
        dateErr = "Invalid Date";
        status = false;
      });
    }
    if (gateNo == "") {
      setState(() {
        gateErr = "Invalid Gate No";
        status = false;
      });
    }

    if (truckNo == "") {
      setState(() {
        truckErr = "Invalid Truck No";
        status = false;
      });
    }
    if (item == "") {
      setState(() {
        itemErr = "Item field is mandatory";
        status = false;
      });
    }
    if (quantity == "") {
      setState(() {
        quantityErr = "Quantity field is mandatory";
        status = false;
      });
    }
    return status;
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
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add Purchase"),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ErrorText(nameErr: mainErr),
                reusableText("Batch No", 10.w),
                FireStoreDropdown(
                  collection: 'production',
                  field: 'batchNumber',
                  selectedValue: selectedBatch,
                  onChanged: (value) {
                    setState(() {
                      selectedBatch = value;
                    });
                  },
                ),
                ErrorText(nameErr: batchErr),
                reusableText("Supplier", 10.w),
                FireStoreDropdown(
                  collection: 'supplier',
                  field: 'name',
                  selectedValue: selectedSuplier,
                  onChanged: (value) {
                    setState(() {
                      selectedSuplier = value;
                    });
                  },
                ),
                ErrorText(nameErr: supplierErr),
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
                reusableText("Gate Number", 10.w),
                buildTextInput(
                  placeHolder: "Gate Number",
                  inputType: "number",
                  initialValue: gateNo,
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      gateNo = value;
                    });
                  }),
                ),
                ErrorText(nameErr: gateErr),
                reusableText("Truck Number", 10.w),
                buildTextInput(
                  placeHolder: "Truck Number",
                  inputType: "text",
                  initialValue: truckNo,
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      truckNo = value;
                    });
                  }),
                ),
                ErrorText(nameErr: truckErr),
                reusableText("Item", 10.w),
                buildTextInput(
                  placeHolder: "Item Name",
                  inputType: "text",
                  initialValue: item,
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      item = value;
                    });
                  }),
                ),
                ErrorText(nameErr: itemErr),
                reusableText("Quantity", 10.w),
                buildTextInput(
                  placeHolder: "Quantity",
                  inputType: "number",
                  iconName: "ang",
                  initialValue: quantity,
                  onChange: ((value) {
                    setState(() {
                      quantity = value;
                    });
                  }),
                ),
                ErrorText(nameErr: quantityErr),
                GestureDetector(
                    onTap: () async {
                      if (validation()) {
                        bool status = await PurchaseController().addPurchase(
                          selectedSuplier: selectedSuplier,
                          selectedBatch: selectedBatch,
                          date: controller.text,
                          truckNo: truckNo,
                          gateNo: gateNo,
                          item: item,
                          quantity: quantity,
                        );
                        if (status) {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        } else {
                          setState(() {
                            mainErr = "Something went wrong";
                          });
                        }
                      }
                    },
                    child: filledButton(AppColors.primaryElement, "SUBMIT")),
              ],
            ),
          ),
        ));
  }
}
