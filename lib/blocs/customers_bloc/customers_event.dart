part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomers extends CustomersEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  const LoadCustomers(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateCustomers extends CustomersEvent {
  final QuerySnapshot<Map<String, dynamic>>? customers;
  final int? pageNumber;
  final int? limit;

  const UpdateCustomers({
    this.customers,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
