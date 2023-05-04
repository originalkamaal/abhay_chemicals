import 'package:abhay_chemicals/screens/users/edit_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UsersRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      {DocumentSnapshot? lastDoc, int limit = 10, String action = "init"});
}

class UsersController extends UsersRepository {
  final FirebaseFirestore _firebaseFirestore;

  UsersController({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<bool> addAdmin(
      {required String name,
      required int mobile,
      required String email,
      required String role,
      String? password}) async {
    bool status = false;

    if (role == "admin") {
      status = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: password ?? "admin@123")
          .then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    }

    if (status == true || role == "user") {
      status == false;
      status = await _firebaseFirestore.collection("employee").add({
        "email": email,
        "name": name,
        "phoneNumber": mobile,
        "role": role
      }).then((value) {
        return true;
      }).catchError((e) {
        return false;
      });
    }

    return status;
  }

  Future<bool> editUser(
      {required DocumentReference reference,
      required String name,
      required int mobile,
      required String email,
      required String role,
      String? password}) async {
    bool status = false;

    status = await reference.update({
      "email": email,
      "name": name,
      "phoneNumber": mobile,
      "role": role
    }).then((value) {
      return true;
    }).catchError((e) {
      return false;
    });

    return status;
  }

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
