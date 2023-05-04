import 'package:cloud_firestore/cloud_firestore.dart';

abstract class OrderReporsitory {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class OrdersController extends OrderReporsitory {
  final FirebaseFirestore _firebaseFirestore;

  OrdersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getSalesByOrderId(
      int orderId) async {
    QuerySnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
        .collection("sales")
        .where("orderId", isEqualTo: orderId)
        .get();
    return doc;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("order")
          .orderBy("date", descending: true)
          .limit(limit)
          .snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("order")
            .startAfterDocument(lastDoc)
            .orderBy("date", descending: true)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("order")
            .endBeforeDocument(lastDoc)
            .orderBy("date", descending: true)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("order")
            .orderBy("date", descending: true)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
