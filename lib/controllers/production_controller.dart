import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductionRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductions(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class ProductionController extends ProductionRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductionController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addNewPalti(DocumentReference e, String date, String palti,
      int temp, String notes) async {
    bool status = false;
    status = await e.update({
      "paltiReport": FieldValue.arrayUnion([
        {"date": date, "palti": palti, "temperature": temp, "note": notes}
      ])
    }).then((value) {
      return true;
    });

    return status;
  }

  Future<bool> addProduction(String date, String batchNumber) async {
    bool status = false;
    status = await _firebaseFirestore.collection("production").add({
      "batchNumber": batchNumber,
      "date": date,
      "enrichment": {"date": "", "note": ""},
      "composite": {"date": "", "note": ""},
      "lastPalti": [],
      "paltiReport": [],
    }).then((value) {
      return true;
    });
    return status;
  }

  Future<bool> editCompEnrich(
      DocumentReference e, String date, String notes, bool isComposting) async {
    bool status = false;

    status = await e.update({
      (isComposting == true ? "composite" : "enrichment"): {
        "date": date,
        "note": notes
      }
    }).then((value) {
      return true;
    });

    return status;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductions(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("production")
          .limit(limit)
          .snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("production")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("production")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("production")
            .limit(limit)
            .snapshots();
      }
    }
  }

  Future getAllPurchaseWithQuantity() async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot<Map<String, dynamic>> productions =
        await _firebaseFirestore.collection("production").get();
    QuerySnapshot<Map<String, dynamic>> purchases =
        await _firebaseFirestore.collection("purchase").get();

    for (var production in productions.docs) {
      var k = production.data();
      k.putIfAbsent("quantity", () => 0);
      data.add(k);
    }

    for (var purchase in purchases.docs) {
      for (var prods in data) {
        if (prods['batchNumber'] == purchase['batchNumber']) {
          prods['quantity'] += purchase['quantity'];
        }
      }
    }

    return data;
  }
}
