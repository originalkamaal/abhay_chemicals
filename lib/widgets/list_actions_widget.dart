import 'package:abhay_chemicals/widgets/confirm_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

DataCell dataTableActions(
    context, QueryDocumentSnapshot<Map<String, dynamic>> e, String route) {
  return DataCell(Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          confirmAction(
              context: context,
              onPressed: () async {
                await FirebaseFirestore.instance
                    .runTransaction((Transaction myTransaction) async {
                  myTransaction.delete(e.reference);
                });
              });
        },
        child: Icon(
          Icons.delete_outline,
          size: 20,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      Visibility(
        visible: route != null && route != "",
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(route, arguments: e);
          },
          child: Icon(
            Icons.edit,
            size: 20,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ),
    ],
  ));
}
