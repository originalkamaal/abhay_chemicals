part of 'suppliers_bloc.dart';

abstract class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object> get props => [];
}

class LoadSuppliers extends SuppliersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadSuppliers(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateSuppliers extends SuppliersEvent {
  final QuerySnapshot<Map<String, dynamic>>? suppliers;
  final int? pageNumber;
  final int? limit;

  const UpdateSuppliers({
    this.suppliers,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
