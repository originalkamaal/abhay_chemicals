import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action});
}

class CustomersController extends CustomersRepository {
  final FirebaseFirestore _firebaseFirestore;

  CustomersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action}) {
    print("Called Customers");

    if (lastDoc == null) {
      return _firebaseFirestore
          .collection("customers")
          .limit(limit)
          .snapshots();
    } else {
      if (action == 1) {
        return _firebaseFirestore
            .collection("customers")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("Customers")
            .endBeforeDocument(lastDoc)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
