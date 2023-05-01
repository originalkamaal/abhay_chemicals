import 'dart:async';

import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SaleBloc extends Bloc<SalesEvent, SalesState> {
  final SalesController _saleController;
  StreamSubscription? _productSubscription;

  SaleBloc({required SalesController saleController})
      : _saleController = saleController,
        super(SalesLoading()) {
    on<LoadSales>(_mapLoadsalesToState);
    on<UpdateSales>(_mapUpdatesalesToState);
    // on<LoadNextsales>(_mapLoadNextsalesToState);
  }

  _mapLoadsalesToState(LoadSales event, Emitter<SalesState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _saleController
          .getAllSales(limit: limit, action: event.direction)
          .listen((sales) {
        add(UpdateSales(sales: sales, pageNumber: 1, limit: limit));
      });
    } else {
      _productSubscription = _saleController
          .getAllSales(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((sales) {
        add(UpdateSales(
            sales: sales,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdatesalesToState(UpdateSales event, Emitter<SalesState> emit) async {
    emit(SalesLoaded(
        sales: event.sales,
        hasMore: (event.sales!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextsalesToState(
  //     LoadNextsales event, Emitter<saleState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _saleController
  //       .getNextsales(event.snap)!
  //       .listen((sales) {
  //     add(Updatesales(sales));
  //   });
  // }
}
