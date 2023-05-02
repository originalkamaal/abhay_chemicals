import 'dart:async';

import 'package:abhay_chemicals/controllers/orders_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersController _orderController;
  StreamSubscription? _productSubscription;

  OrderBloc({required OrdersController orderController})
      : _orderController = orderController,
        super(OrdersLoading()) {
    on<LoadOrders>(_mapLoadOrdersToState);
    on<UpdateOrders>(_mapUpdateOrdersToState);
    // on<LoadNextOrders>(_mapLoadNextOrdersToState);
  }

  _mapLoadOrdersToState(LoadOrders event, Emitter<OrdersState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _orderController
          .getAllOrders(limit: limit, action: event.direction)
          .listen((orders) {
        add(UpdateOrders(orders: orders, pageNumber: 1, limit: limit));
      });
    } else {
      _productSubscription = _orderController
          .getAllOrders(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((orders) {
        add(UpdateOrders(
            orders: orders,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdateOrdersToState(UpdateOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoaded(
        orders: event.orders,
        hasMore: (event.orders!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextOrdersToState(
  //     LoadNextOrders event, Emitter<OrderState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _OrderController
  //       .getNextOrders(event.snap)!
  //       .listen((Orders) {
  //     add(UpdateOrders(Orders));
  //   });
  // }
}
