part of 'sales_bloc.dart';

abstract class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object> get props => [];
}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final QuerySnapshot<Map<String, dynamic>>? sales;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const SalesLoaded(
      {this.sales, this.limit = 3, this.hasMore = true, this.pageNumber = 1});

  @override
  List<Object> get props => [sales!, limit];
}
