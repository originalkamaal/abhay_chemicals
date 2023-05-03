import 'dart:async';

import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ordersales_event.dart';
part 'ordersales_state.dart';

class OrderSaleBloc extends Bloc<OrderSalesEvent, OrderSalesState> {
  final OrderSalesController _orderSaleController;
  StreamSubscription? _productSubscription;

  OrderSaleBloc({required OrderSalesController orderSaleController})
      : _orderSaleController = orderSaleController,
        super(OrderSalesLoading()) {
    on<LoadOrderSales>(_mapLoadOrderSalesToState);
    on<UpdateOrderSales>(_mapUpdateOrderSalesToState);
    // on<LoadNextOrderSales>(_mapLoadNextOrderSalesToState);
  }

  _mapLoadOrderSalesToState(
      LoadOrderSales event, Emitter<OrderSalesState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _orderSaleController
          .getAllOrderSales(limit: limit, action: event.direction)
          .listen((orderSales) {
        add(UpdateOrderSales(
            orderSales: orderSales, pageNumber: 1, limit: limit));
      });
    } else {
      _productSubscription = _orderSaleController
          .getAllOrderSales(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((orderSales) {
        add(UpdateOrderSales(
            orderSales: orderSales,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdateOrderSalesToState(
      UpdateOrderSales event, Emitter<OrderSalesState> emit) async {
    emit(OrderSalesLoaded(
        orderSales: event.orderSales,
        hasMore: (event.orderSales!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextOrderSalesToState(
  //     LoadNextOrderSales event, Emitter<OrderSaleState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _OrderSaleController
  //       .getNextOrderSales(event.snap)!
  //       .listen((OrderSales) {
  //     add(UpdateOrderSales(OrderSales));
  //   });
  // }
}
