import 'dart:async';

import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PurchaseController _purchaseController;
  StreamSubscription? _purchaseSubscription;

  PurchaseBloc({required PurchaseController purchaseController})
      : _purchaseController = purchaseController,
        super(PurchasesLoading()) {
    on<LoadPurchases>(_mapLoadPurchasesToState);
    on<UpdatePurchases>(_mapUpdatePurchasesToState);
    // on<LoadNextPurchases>(_mapLoadNextPurchasesToState);
  }

  _mapLoadPurchasesToState(
      LoadPurchases event, Emitter<PurchaseState> emit) async {
    _purchaseSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _purchaseSubscription = _purchaseController
          .getAllPurchases(limit: limit, action: event.direction)
          .listen((purchases) {
        add(UpdatePurchases(purchases: purchases, pageNumber: 1, limit: limit));
      });
    } else {
      _purchaseSubscription = _purchaseController
          .getAllPurchases(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((purchases) {
        add(UpdatePurchases(
            purchases: purchases,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdatePurchasesToState(
      UpdatePurchases event, Emitter<PurchaseState> emit) async {
    emit(PurchasesLoaded(
        purchases: event.purchases,
        hasMore: (event.purchases!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }
}
