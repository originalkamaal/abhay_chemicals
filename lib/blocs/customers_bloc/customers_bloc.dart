import 'dart:async';

import 'package:abhay_chemicals/controllers/customers_controllers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomerState> {
  final CustomersController _customersController;
  StreamSubscription? _productSubscription;

  CustomersBloc({required CustomersController customersController})
      : _customersController = customersController,
        super(CustomersLoading()) {
    on<LoadCustomers>(_mapLoadCustomersToState);
    on<UpdateCustomers>(_mapUpdateCustomersToState);
    // on<LoadNextCustomers>(_mapLoadNextCustomersToState);
  }

  _mapLoadCustomersToState(
      LoadCustomers event, Emitter<CustomerState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _customersController
          .getAllCustomers(limit: limit, action: event.direction)
          .listen((customers) {
        add(UpdateCustomers(customers: customers, pageNumber: 1, limit: limit));
      });
    } else {
      print("Last doc is there");
      _productSubscription = _customersController
          .getAllCustomers(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((Customers) {
        add(UpdateCustomers(
            customers: Customers,
            pageNumber: event.direction == 1
                ? event.pageNumber + 1
                : event.pageNumber - 1,
            limit: event.limit));
      });
    }
  }

  _mapUpdateCustomersToState(
      UpdateCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomersLoaded(
        customers: event.customers,
        hasMore: (event.customers!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextCustomersToState(
  //     LoadNextCustomers event, Emitter<Customerstate> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _CustomersController
  //       .getNextCustomers(event.snap)!
  //       .listen((Customers) {
  //     add(UpdateCustomers(Customers));
  //   });
  // }
}