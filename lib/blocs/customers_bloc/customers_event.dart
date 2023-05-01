part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomers extends CustomersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final int direction;
  final int pageNumber;

  LoadCustomers(
      {this.lastDoc, this.limit = 3, this.direction = 1, this.pageNumber = 1});
}

class UpdateCustomers extends CustomersEvent {
  final QuerySnapshot<Map<String, dynamic>>? customers;
  final int? pageNumber;
  final int? limit;

  UpdateCustomers({
    this.customers,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
