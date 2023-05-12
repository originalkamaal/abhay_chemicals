import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCompEnrich extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> e;
  final bool edit;

  const EditCompEnrich({super.key, required this.e, required this.edit});

  @override
  State<EditCompEnrich> createState() => _EditCompEnrichState();
}

class _EditCompEnrichState extends State<EditCompEnrich> {
  DateTime selectedDate = DateTime.now();
  String notes = "";

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
          child: Text("Edit ${widget.edit ? "Composting" : "Enrichment"}"),
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
                    notes = "";
                  });
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(onPressed: () async {}, child: const Text("Submit"))
          ],
        )
      ],
    ));
  }
}
