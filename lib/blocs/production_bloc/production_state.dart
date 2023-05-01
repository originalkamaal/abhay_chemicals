part of 'production_bloc.dart';

abstract class ProductionState extends Equatable {
  const ProductionState();

  @override
  List<Object> get props => [];
}

class ProductionsLoading extends ProductionState {}

class ProductionsLoaded extends ProductionState {
  final QuerySnapshot<Map<String, dynamic>>? productions;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const ProductionsLoaded(
      {this.productions,
      this.limit = 10,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [productions!, limit];
}
