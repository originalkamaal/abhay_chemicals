import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class UsersController extends UsersRepository {
  final FirebaseFirestore _firebaseFirestore;

  UsersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"}) {
    if (lastDoc == null) {
      return _firebaseFirestore.collection("employee").limit(limit).snapshots();
    } else {
      if (action == "forward") {
        return _firebaseFirestore
            .collection("employee")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else if (action == "back") {
        return _firebaseFirestore
            .collection("employee")
            .endBeforeDocument(lastDoc)
            .limitToLast(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("employee")
            .limit(limit)
            .snapshots();
      }
    }
  }
}
