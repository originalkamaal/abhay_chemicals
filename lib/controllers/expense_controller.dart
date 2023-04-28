import 'package:abhay_chemicals/models/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ExpenseRepository {
  Stream<List<Expense>> getAllExpenses();
}

class ExpenseController extends ExpenseRepository {
  final FirebaseFirestore _firebaseFirestore;

  ExpenseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Expense>> getAllExpenses() {
    return _firebaseFirestore
        .collection("expenses")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Expense.fromSnapshot(e)).toList();
    });
  }
}
