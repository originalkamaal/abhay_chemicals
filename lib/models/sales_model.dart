//Models

import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final String id;
  final String careOf;
  final String challanNo;
  final String customer;
  final String date;
  final String item;
  final String orderId;
  final String phoneNo;
  final String quantity;
  final String village;

  Sales({
    required this.id,
    required this.careOf,
    required this.challanNo,
    required this.customer,
    required this.date,
    required this.item,
    required this.orderId,
    required this.phoneNo,
    required this.quantity,
    required this.village,
  });

  static Sales fromSnapshot(DocumentSnapshot snap) {
    return Sales(
      id: snap.id,
      careOf: snap['careOf'].toString(),
      challanNo: snap['challanNumber'].toString(),
      customer: snap['customer'].toString(),
      date: snap['date'].toString(),
      item: snap['item'].toString(),
      orderId: snap['orderId'].toString(),
      phoneNo: snap['phoneNumber'].toString(),
      quantity: snap['quantity'].toString(),
      village: snap['village'].toString(),
    );
  }
}
