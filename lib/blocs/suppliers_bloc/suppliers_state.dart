part of 'suppliers_bloc.dart';

abstract class SuppliersState extends Equatable {
  const SuppliersState();

  @override
  List<Object> get props => [];
}

class SuppliersLoading extends SuppliersState {}

class SuppliersLoaded extends SuppliersState {
  final QuerySnapshot<Map<String, dynamic>>? suppliers;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const SuppliersLoaded(
      {this.suppliers,
      this.limit = 3,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [suppliers!, limit];
}
