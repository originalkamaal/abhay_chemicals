part of 'purchase_bloc.dart';

abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object> get props => [];
}

class PurchasesLoading extends PurchaseState {}

class PurchasesLoaded extends PurchaseState {
  final QuerySnapshot<Map<String, dynamic>>? purchases;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const PurchasesLoaded(
      {this.purchases,
      this.limit = 3,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [purchases!, limit];
}
