import 'package:abhay_chemicals/models/supplier_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SupplierRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action});
}

class SupplierController extends SupplierRepository {
  final FirebaseFirestore _firebaseFirestore;

  SupplierController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action}) {
    print("Called prodctions");

    if (lastDoc == null) {
      return _firebaseFirestore.collection("Supplier").limit(limit).snapshots();
    } else {
      if (action == 1) {
        return _firebaseFirestore
            .collection("Supplier")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("Supplier")
            .endBeforeDocument(lastDoc)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
