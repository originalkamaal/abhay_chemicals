import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewSales extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> e;

  const AddNewSales({super.key, required this.e});

  @override
  State<AddNewSales> createState() => _AddNewSalesState();
}

class _AddNewSalesState extends State<AddNewSales> {
  DateTime selectedDate = DateTime.now();
  int? challanNo;
  int? quantity;
  String error = "";

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
          child: Text("Add New Sales Order Id #${widget.e['orderId']}"),
        ),
        Visibility(
            visible: error != "",
            child: Center(
              child: Text(
                "",
                style: TextStyle(color: Colors.red),
              ),
            )),
        Row(
          children: [
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            TextButton(
                onPressed: () => _selectDate(context),
                child: const Text("Select Date"))
          ],
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Challan No"),
          onChanged: (value) {
            setState(() {
              challanNo = int.parse(value);
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Quantity"),
          onChanged: (value) {
            setState(() {
              quantity = int.parse(value);
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
                    quantity = null;
                    challanNo = null;
                  });
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  if (quantity != null && challanNo != null) {
                    setState(() {
                      error = "";
                    });
                    bool status = await OrderSalesController().addNewSales(
                      widget.e,
                      challanNo!,
                      quantity!,
                    );
                    if (status = true) {
                      Navigator.pop(context);
                    }
                  } else {
                    setState(() {
                      error = "Please fill all fields";
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
