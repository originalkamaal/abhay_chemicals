import 'package:abhay_chemicals/screens/sales/add_direct_sales.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SalesRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrderSales(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class OrderSalesController extends SalesRepository {
  final FirebaseFirestore _firebaseFirestore;

  OrderSalesController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  static Future<bool> addDirectSales({
    required String orderId,
    required String challanNo,
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
        .collection("sales")
        .add({
          "careOf": careof,
          "customer": customer,
          "date": date,
          "fulfilled": fullFilled == "" ? 0 : int.parse(fullFilled),
          "item": item,
          "orderId": int.parse(orderId),
          "quantity": int.parse(quantity),
          "village": village,
          "challanNumber": challanNo
        })
        .then((value) => true)
        .catchError((onError) => false);
    return status;
  }

  Future addNewSales(DocumentSnapshot e, int challanNo, int quantity) async {
    bool status = false;

    DocumentReference documentReference =
        FirebaseFirestore.instance.doc((e['careOf'] as DocumentReference).path);
    status = await documentReference.get().then((careOf) async {
      if (careOf.exists) {
        return await _firebaseFirestore.collection("sales").add({
          "careOf": careOf['name'],
          "challanNumber": challanNo,
          "customer": e['customer'],
          "date": e['date'],
          "item": e['item'],
          "orderId": e['orderId'],
          "phoneNumber": careOf['phoneNumber'],
          "quantity": quantity,
          "village": e['village'],
        }).then((value) {
          return true;
        });
      } else {
        return false;
      }
    });

    return status;
  }

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
