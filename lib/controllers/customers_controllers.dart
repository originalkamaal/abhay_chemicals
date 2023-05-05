import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class CustomersController extends CustomersRepository {
  final FirebaseFirestore _firebaseFirestore;

  CustomersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addCustomer(
      {required String name,
      required int mobile,
      required String village,
      required DocumentReference? reference,
      required String billingAddress,
      required String billingPin,
      required String shippingAddress,
      required String shippingPin}) async {
    bool status = false;
    status = await _firebaseFirestore.collection("customer").add({
      "name": name,
      "phoneNumber": mobile,
      "village": village,
      "careOf": reference,
      "billingAddress": billingAddress,
      "shippingAddress": shippingAddress,
      "billingPincode": billingPin.isEmpty ? billingPin : int.parse(billingPin),
      "shippingPincode":
          shippingPin.isEmpty ? shippingPin : int.parse(shippingPin),
    }).then((value) {
      return true;
    }).catchError((onError) {
      return false;
    });
    return status;
  }

  Future<bool> editCustomer(
      {required DocumentReference customerReference,
      required String name,
      required int mobile,
      required String village,
      required DocumentReference? reference,
      required String billingAddress,
      required String billingPin,
      required String shippingAddress,
      required String shippingPin}) async {
    bool status = false;
    status = await customerReference.update({
      "name": name,
      "phoneNumber": mobile,
      "village": village,
      "careOf": reference,
      "billingAddress": billingAddress,
      "shippingAddress": shippingAddress,
      "billingPincode": billingPin.isEmpty ? billingPin : int.parse(billingPin),
      "shippingPincode":
          shippingPin.isEmpty ? shippingPin : int.parse(shippingPin),
    }).then((value) {
      return true;
    }).catchError((onError) {
      return false;
    });
    return status;
  }

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
