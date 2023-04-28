import 'package:abhay_chemicals/models/production_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductionRepository {
  Stream<List<Production>> getAllProductions();
}

class ProductionController extends ProductionRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductionController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Production>> getAllProductions() {
    return _firebaseFirestore
        .collection("production")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Production.fromSnapshot(e)).toList();
    });
  }
}
