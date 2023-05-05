import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PurchaseRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class PurchaseController extends PurchaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  PurchaseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addPurchase(
      {required String selectedSuplier,
      required String selectedBatch,
      required String date,
      required String truckNo,
      required String gateNo,
      required String item,
      required String quantity}) async {
    bool status = false;
    status = await _firebaseFirestore.collection("purchase").add({
      "supplier": selectedSuplier,
      "batchNumber": selectedBatch,
      "date": date,
      "truckNumber": int.parse(truckNo),
      "gateNumber": int.parse(gateNo),
      "item": item,
      "quantity": int.parse(quantity)
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });

    return status;
  }

  Future<bool> editPurchase(
      {required DocumentReference reference,
      required String selectedSuplier,
      required String selectedBatch,
      required String date,
      required String truckNo,
      required String gateNo,
      required String item,
      required String quantity}) async {
    bool status = false;
    status = await reference.update({
      "supplier": selectedSuplier,
      "batchNumber": selectedBatch,
      "date": date,
      "truckNumber": int.parse(truckNo),
      "gateNumber": int.parse(gateNo),
      "item": item,
      "quantity": int.parse(quantity)
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });

    return status;
  }

  Future<Map> getBatchPurchases(String batchNumber) async {
    int totalQuantities = 0;
    QuerySnapshot<Map<String, dynamic>> documentSnapshots =
        await _firebaseFirestore
            .collection("purchase")
            .where("batchNumber", isEqualTo: batchNumber)
            .get();

    for (var i = 0; i < documentSnapshots.docs.length; i++) {
      totalQuantities =
          (totalQuantities + documentSnapshots.docs[i]['quantity']).toInt();
    }

    return {
      "totalQuantities": totalQuantities.toString(),
      "docs": documentSnapshots
    };
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("purchase")
          .orderBy("date", descending: true)
          .limit(limit)
          .snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("purchase")
            .orderBy("date", descending: true)
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("purchase")
            .orderBy("date", descending: true)
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("purchase")
            .orderBy("date", descending: true)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
