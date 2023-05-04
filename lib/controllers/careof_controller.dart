import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersCareofRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersCareof(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class UsersCareofController extends UsersCareofRepository {
  final FirebaseFirestore _firebaseFirestore;

  UsersCareofController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addCareOf(
      {required String name,
      required int mobile,
      required String email}) async {
    bool status = false;
    status = await _firebaseFirestore
        .collection("careof")
        .add({"email": email, "name": name, "phoneNumber": mobile}).then(
            (value) => true);

    return status;
  }

  Future<bool> editCareOf(
      {required DocumentReference reference,
      required String name,
      required int mobile,
      required String email}) async {
    bool status = false;

    status = await reference
        .set({"email": email, "name": name, "phoneNumber": mobile}).then(
            (value) => true);

    return status;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersCareof(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("careof").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("careof")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("careof")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore.collection("careof").limit(limit).snapshots();
      }
    }
  }
}
