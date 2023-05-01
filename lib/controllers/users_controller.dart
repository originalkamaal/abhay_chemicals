import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action});
}

class UsersController extends UsersRepository {
  final FirebaseFirestore _firebaseFirestore;

  UsersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {DocumentSnapshot? lastDoc, int limit = 10, required int action}) {
    print("Called users");

    if (lastDoc == null) {
      return _firebaseFirestore.collection("Users").limit(limit).snapshots();
    } else {
      if (action == 1) {
        return _firebaseFirestore
            .collection("Users")
            .startAfterDocument(lastDoc)
            .limit(limit)
            .snapshots();
      } else {
        return _firebaseFirestore
            .collection("Users")
            .endBeforeDocument(lastDoc)
            .limit(limit)
            .snapshots();
      }
    }
  }
}
