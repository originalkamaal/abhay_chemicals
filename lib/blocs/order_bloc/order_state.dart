part of 'order_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final QuerySnapshot<Map<String, dynamic>>? orders;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const OrdersLoaded(
      {this.orders, this.limit = 10, this.hasMore = true, this.pageNumber = 1});

  @override
  List<Object> get props => [orders!, limit];
}
