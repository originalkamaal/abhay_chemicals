import 'dart:async';

import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/production_model.dart';

part 'production_event.dart';
part 'production_state.dart';

class ProductionBloc extends Bloc<ProductionEvent, ProductionState> {
  final ProductionController _productionController;
  StreamSubscription? _productSubscription;

  ProductionBloc({required ProductionController productionController})
      : _productionController = productionController,
        super(ProductionsLoading()) {
    on<LoadProductions>(_mapLoadProductionsToState);
    on<UpdateProductions>(_mapUpdateProductionsToState);
  }

  _mapLoadProductionsToState(
      LoadProductions event, Emitter<ProductionState> emit) async {
    _productSubscription?.cancel();

    _productSubscription =
        _productionController.getAllProductions().listen((productions) {
      add(UpdateProductions(productions));
    });
  }

  _mapUpdateProductionsToState(
      UpdateProductions event, Emitter<ProductionState> emit) async {
    print("Loading");
    emit(ProductionsLoaded(productions: event.productions));
  }
}
