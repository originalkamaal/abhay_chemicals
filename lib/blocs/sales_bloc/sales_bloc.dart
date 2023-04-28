import 'dart:async';

import 'package:abhay_chemicals/controllers/sales_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/sales_model.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SalesController _salesController;
  StreamSubscription? _salesSubscription;

  SalesBloc({required SalesController salesControler})
      : _salesController = salesControler,
        super(SalesLoading()) {
    on<LoadSales>(_mapLoadSalesToState);
    on<UpdateSales>(_mapUpdateSalesToState);
  }

  FutureOr<void> _mapLoadSalesToState(
      LoadSales event, Emitter<SalesState> emit) async {
    _salesSubscription?.cancel();

    _salesSubscription = _salesController.getAllSales().listen((Sales) {
      add(UpdateSales(Sales));
    });
  }

  _mapUpdateSalesToState(UpdateSales event, Emitter<SalesState> emit) async {
    print("Loading");
    emit(SalesLoaded(sales: event.Saless));
  }
}
