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

  static Future<bool> addOrder({
    required String orderId,
    required String date,
    required String customer,
    required String careof,
    required String fullFilled,
    required String village,
    required String item,
    required String quantity,
  }) async {
    bool status = false;
    status = await FirebaseFirestore.instance
        .collection("order")
        .add({
          "careOf": careof,
          "customer": customer,
          "date": date,
          "fulfilled": fullFilled == "" ? 0 : int.parse(fullFilled),
          "item": item,
          "orderId": int.parse(orderId),
          "quantity": int.parse(quantity),
          "village": village,
        })
        .then((value) => true)
        .catchError((onError) => false);
    return status;
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
