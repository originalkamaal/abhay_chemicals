part of 'ordersales_bloc.dart';

abstract class OrderSalesEvent extends Equatable {
  const OrderSalesEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderSales extends OrderSalesEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadOrderSales(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateOrderSales extends OrderSalesEvent {
  final QuerySnapshot<Map<String, dynamic>>? orderSales;
  final int? pageNumber;
  final int? limit;

  const UpdateOrderSales({
    this.orderSales,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
