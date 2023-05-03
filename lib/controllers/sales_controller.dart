import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SalesRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrderSales(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class OrderSalesController extends SalesRepository {
  final FirebaseFirestore _firebaseFirestore;

  OrderSalesController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrderSales(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("sales")
          .orderBy("date", descending: true)
          .limit(limit)
          .snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("sales")
            .startAfterDocument(lastDoc)
            .orderBy("date", descending: true)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("sales")
            .endBeforeDocument(lastDoc)
            .orderBy("date", descending: true)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("sales")
            .orderBy("date", descending: true)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
