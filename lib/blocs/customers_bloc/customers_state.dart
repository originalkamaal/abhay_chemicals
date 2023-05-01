part of 'customers_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomersLoading extends CustomerState {}

class CustomersLoaded extends CustomerState {
  final QuerySnapshot<Map<String, dynamic>>? customers;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const CustomersLoaded(
      {this.customers,
      this.limit = 3,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [customers!, limit];
}
