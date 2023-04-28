import 'package:abhay_chemicals/models/production_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductionRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductions(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action});
}

class ProductionController extends ProductionRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductionController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductions(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action}) {
    print("Called prodctions");

    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("production")
          .limit(limit)
          .snapshots();
    } else {
      if (action == 1) {
        return _firebaseFirestore
            .collection("production")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("production")
            .endBeforeDocument(lastDoc)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
