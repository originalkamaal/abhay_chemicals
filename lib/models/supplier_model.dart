import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  final String id;

  Supplier({
    required this.id,
  });

  static Supplier fromSnapshot(DocumentSnapshot snap) {
    Supplier supplier = Supplier(
      id: snap.id,
    );
    return supplier;
  }
}
