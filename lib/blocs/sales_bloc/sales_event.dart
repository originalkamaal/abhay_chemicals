part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

class LoadSales extends SalesEvent {}

class UpdateSales extends SalesEvent {
  final List<Sales> Saless;

  UpdateSales(this.Saless);

  @override
  List<Object> get props => [];
}
