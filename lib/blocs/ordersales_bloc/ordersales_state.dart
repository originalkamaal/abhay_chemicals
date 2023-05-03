part of 'ordersales_bloc.dart';

abstract class OrderSalesState extends Equatable {
  const OrderSalesState();

  @override
  List<Object> get props => [];
}

class OrderSalesLoading extends OrderSalesState {}

class OrderSalesLoaded extends OrderSalesState {
  final QuerySnapshot<Map<String, dynamic>>? orderSales;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const OrderSalesLoaded(
      {this.orderSales,
      this.limit = 10,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [orderSales!, limit];
}
