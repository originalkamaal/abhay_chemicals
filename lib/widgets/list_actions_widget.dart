import 'package:abhay_chemicals/widgets/confirm_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

DataCell dataTableActions(context, DocumentReference<Map<String, dynamic>> e) {
  final user = FirebaseAuth.instance.currentUser;

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
                  myTransaction.delete(e);
                });
              });
        },
        child: Icon(
          Icons.delete_outline,
          size: 20,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.edit,
          size: 20,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.remove_red_eye,
          size: 20,
          color: Colors.black.withOpacity(0.3),
        ),
      )
    ],
  ));
}
