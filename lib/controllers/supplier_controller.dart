import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SupplierRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class SupplierController extends SupplierRepository {
  final FirebaseFirestore _firebaseFirestore;

  SupplierController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> editSupllier(
      {required DocumentReference reference,
      required String mobile,
      required String name,
      required String email}) async {
    bool status = false;
    status = await reference
        .set({"name": name, "phoneNumber": int.parse(mobile), "email": email})
        .then((value) => true)
        .catchError((e) => false);

    return status;
  }

  // addNewSupplier

  Future<bool> addNewSupplier(
      {required String mobile,
      required String name,
      required String email}) async {
    bool status = false;
    status = await FirebaseFirestore.instance
        .collection("supplier")
        .add({"name": name, "phoneNumber": int.parse(mobile), "email": email})
        .then((value) => true)
        .catchError((e) => false);

    return status;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSuppliers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("supplier").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("supplier")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("supplier")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("supplier")
            .limit(limit)
            .snapshots();
      }
    }
  }
}
