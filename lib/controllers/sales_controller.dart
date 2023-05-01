import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SalesRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSales(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class SalesController extends SalesRepository {
  final FirebaseFirestore _firebaseFirestore;

  SalesController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSales(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    print("Called prodctions");

    if (lastDoc == null) {
      return _firebaseFirestore.collection("sales").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("sales")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("sales")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore.collection("sales").limit(limit).snapshots();
      }
    }
  }
}
