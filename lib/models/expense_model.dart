import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id;
  final String amount;
  final String date;
  final String description;

  Expense({
    // required this.paltiReport,
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
  });

  static Expense fromSnapshot(DocumentSnapshot snap) {
    Expense expense = Expense(
      id: snap.id,
      amount: (snap['amount']).toString(),
      date: snap['date'],
      description: snap['description'],
    );

    return expense;
  }
}
