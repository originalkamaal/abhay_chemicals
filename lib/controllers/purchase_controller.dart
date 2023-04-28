import 'package:abhay_chemicals/models/purhcase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PurchaseRepository {
  Stream<List<Purchase>> getAllPurchases();
}

class PurchaseController extends PurchaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  PurchaseController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Purchase>> getAllPurchases() {
    return _firebaseFirestore
        .collection("purchase")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Purchase.fromSnapshot(e)).toList();
    });
  }
}
