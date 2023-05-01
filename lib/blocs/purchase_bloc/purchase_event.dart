part of 'purchase_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class LoadPurchases extends PurchaseEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final int direction;
  final int pageNumber;

  LoadPurchases(
      {this.lastDoc, this.limit = 3, this.direction = 1, this.pageNumber = 1});
}

class UpdatePurchases extends PurchaseEvent {
  final QuerySnapshot<Map<String, dynamic>>? purchases;
  final int? pageNumber;
  final int? limit;

  UpdatePurchases({
    this.purchases,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
