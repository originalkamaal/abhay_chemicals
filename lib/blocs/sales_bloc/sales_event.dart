part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

class LoadSales extends SalesEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadSales(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateSales extends SalesEvent {
  final QuerySnapshot<Map<String, dynamic>>? sales;
  final int? pageNumber;
  final int? limit;

  const UpdateSales({
    this.sales,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
