//Models

import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  final String batchNumber;
  final String date;
  final String gateNumber;
  final String id;
  final String item;
  final String quantity;
  final String supplier;
  final String truckNumber;

  Purchase(
      {required this.batchNumber,
      required this.date,
      required this.gateNumber,
      required this.id,
      required this.item,
      required this.quantity,
      required this.supplier,
      required this.truckNumber});

  static Purchase fromSnapshot(DocumentSnapshot snap) {
    return Purchase(
        batchNumber: snap['batchNumber'],
        date: snap['date'],
        gateNumber: snap['gateNumber'].toString(),
        id: snap.id,
        item: snap['item'],
        quantity: snap['quantity'].toString(),
        supplier: snap['supplier'],
        truckNumber: snap['truckNumber'].toString());
  }
}
