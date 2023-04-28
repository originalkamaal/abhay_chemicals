part of 'purchase_bloc.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final List<Purchase> purchase;

  const PurchaseLoaded({this.purchase = const <Purchase>[]});

  @override
  List<Object> get props => [purchase];
}
