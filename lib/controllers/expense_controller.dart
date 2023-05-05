import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ExpenseRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllExpenses(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class ExpenseController extends ExpenseRepository {
  final FirebaseFirestore _firebaseFirestore;

  ExpenseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addExpense(
      {required String amount,
      required String date,
      String? description}) async {
    bool status = await _firebaseFirestore.collection("expenses").add({
      "amount": int.parse(amount),
      "date": date,
      "description": description ?? ""
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });

    return status;
  }

  Future<bool> editExpense(
      {required DocumentReference reference,
      required String amount,
      required String date,
      String? description}) async {
    bool status = await reference.update({
      "amount": int.parse(amount),
      "date": date,
      "description": description ?? ""
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });

    return status;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllExpenses(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("expenses").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("expenses")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("expenses")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("expenses")
            .limit(limit)
            .snapshots();
      }
    }
  }
}
