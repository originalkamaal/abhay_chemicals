part of 'order_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrdersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadOrders(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateOrders extends OrdersEvent {
  final QuerySnapshot<Map<String, dynamic>>? orders;
  final int? pageNumber;
  final int? limit;

  const UpdateOrders({
    this.orders,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
