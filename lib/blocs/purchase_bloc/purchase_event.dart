part of 'purchase_bloc.dart';

abstract class PurchaseEvent extends Equatable {
  const PurchaseEvent();

  @override
  List<Object> get props => [];
}

class LoadPurchase extends PurchaseEvent {}

class UpdatePurchase extends PurchaseEvent {
  final List<Purchase> purchases;

  UpdatePurchase(this.purchases);

  @override
  List<Object> get props => [];
}
