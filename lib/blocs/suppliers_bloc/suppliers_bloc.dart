import 'dart:async';

import 'package:abhay_chemicals/controllers/supplier_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  final SupplierController _supplierController;
  StreamSubscription? _productSubscription;

  SuppliersBloc({required SupplierController supplierController})
      : _supplierController = supplierController,
        super(SuppliersLoading()) {
    on<LoadSuppliers>(_mapLoadSuppliersToState);
    on<UpdateSuppliers>(_mapUpdateSuppliersToState);
    // on<LoadNextSuppliers>(_mapLoadNextSuppliersToState);
  }

  _mapLoadSuppliersToState(
      LoadSuppliers event, Emitter<SuppliersState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _supplierController
          .getAllSuppliers(limit: limit, action: event.direction)
          .listen((suppliers) {
        add(UpdateSuppliers(suppliers: suppliers, pageNumber: 1, limit: limit));
      });
    } else {
      print("Last doc is there");
      _productSubscription = _supplierController
          .getAllSuppliers(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((suppliers) {
        add(UpdateSuppliers(
            suppliers: suppliers,
            pageNumber: event.direction == 1
                ? event.pageNumber + 1
                : event.pageNumber - 1,
            limit: event.limit));
      });
    }
  }

  _mapUpdateSuppliersToState(
      UpdateSuppliers event, Emitter<SuppliersState> emit) async {
    emit(SuppliersLoaded(
        suppliers: event.suppliers,
        hasMore: (event.suppliers!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextSuppliersToState(
  //     LoadNextSuppliers event, Emitter<SupplierState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _SupplierController
  //       .getNextSuppliers(event.snap)!
  //       .listen((Suppliers) {
  //     add(UpdateSuppliers(Suppliers));
  //   });
  // }
}
