part of 'suppliers_bloc.dart';

abstract class SuppliersEvent extends Equatable {
  const SuppliersEvent();

  @override
  List<Object> get props => [];
}

class LoadSuppliers extends SuppliersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final int direction;
  final int pageNumber;

  LoadSuppliers(
      {this.lastDoc, this.limit = 3, this.direction = 1, this.pageNumber = 1});
}

class UpdateSuppliers extends SuppliersEvent {
  final QuerySnapshot<Map<String, dynamic>>? suppliers;
  final int? pageNumber;
  final int? limit;

  UpdateSuppliers({
    this.suppliers,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
