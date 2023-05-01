import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class CustomersController extends CustomersRepository {
  final FirebaseFirestore _firebaseFirestore;

  CustomersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("customer").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("customer")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("customer")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("customer")
            .limit(limit)
            .snapshots();
      }
    }
  }
}
