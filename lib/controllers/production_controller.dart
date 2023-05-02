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
}
