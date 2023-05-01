import 'dart:async';

import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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
    // on<LoadNextProductions>(_mapLoadNextProductionsToState);
  }

  _mapLoadProductionsToState(
      LoadProductions event, Emitter<ProductionState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _productionController
          .getAllProductions(limit: limit, action: event.direction)
          .listen((productions) {
        add(UpdateProductions(
            productions: productions, pageNumber: 1, limit: limit));
      });
    } else {
      print("Last doc is there");
      _productSubscription = _productionController
          .getAllProductions(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((productions) {
        add(UpdateProductions(
            productions: productions,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
            limit: event.limit));
      });
    }
  }

  _mapUpdateProductionsToState(
      UpdateProductions event, Emitter<ProductionState> emit) async {
    emit(ProductionsLoaded(
        productions: event.productions,
        hasMore: (event.productions!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextProductionsToState(
  //     LoadNextProductions event, Emitter<ProductionState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _productionController
  //       .getNextProductions(event.snap)!
  //       .listen((productions) {
  //     add(UpdateProductions(productions));
  //   });
  // }
}
