import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PurchaseRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class PurchaseController extends PurchaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  PurchaseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPurchases(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("purchase").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("purchase")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("purchase")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("purchase")
            .limit(limit)
            .snapshots();
      }
    }
  }
}
