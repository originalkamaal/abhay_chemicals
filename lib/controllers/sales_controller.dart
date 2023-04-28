import 'package:abhay_chemicals/models/production_model.dart';
import 'package:abhay_chemicals/models/sales_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SalesRepository {
  Stream<List<Sales>> getAllSales();
}

class SalesController extends SalesRepository {
  final FirebaseFirestore _firebaseFirestore;

  SalesController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Sales>> getAllSales() {
    print("SaleControler -> GetAllSales");
    return _firebaseFirestore.collection("sales").snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Sales.fromSnapshot(e)).toList();
    });
  }
}
