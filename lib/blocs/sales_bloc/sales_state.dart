part of 'sales_bloc.dart';

abstract class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object> get props => [];
}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<Sales> sales;

  const SalesLoaded({this.sales = const <Sales>[]});

  @override
  List<Object> get props => [Sales];
}
