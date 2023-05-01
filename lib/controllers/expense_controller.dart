import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ExpenseRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllExpenses(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class ExpenseController extends ExpenseRepository {
  final FirebaseFirestore _firebaseFirestore;

  ExpenseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
