import 'dart:async';

import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/purhcase_model.dart';

part 'purchase_event.dart';
part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  final PurchaseController _purchaseController;
  StreamSubscription? _purchaseSubscription;

  PurchaseBloc({required PurchaseController purchaseControler})
      : _purchaseController = purchaseControler,
        super(PurchaseLoading()) {
    on<LoadPurchase>(_mapLoadPurchaseToState);
    on<UpdatePurchase>(_mapUpdatePurchaseToState);
  }

  FutureOr<void> _mapLoadPurchaseToState(
      LoadPurchase event, Emitter<PurchaseState> emit) async {
    _purchaseSubscription?.cancel();

    _purchaseSubscription =
        _purchaseController.getAllPurchases().listen((Purchase) {
      add(UpdatePurchase(Purchase));
    });
  }

  _mapUpdatePurchaseToState(
      UpdatePurchase event, Emitter<PurchaseState> emit) async {
    print("Loading");
    emit(PurchaseLoaded(purchase: event.purchases));
  }
}
