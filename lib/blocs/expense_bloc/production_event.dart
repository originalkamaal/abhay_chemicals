part of 'production_bloc.dart';

abstract class ProductionEvent extends Equatable {
  const ProductionEvent();

  @override
  List<Object> get props => [];
}

class LoadProductions extends ProductionEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final int direction;
  final int pageNumber;

  LoadProductions(
      {this.lastDoc, this.limit = 3, this.direction = 1, this.pageNumber = 1});
}

class UpdateProductions extends ProductionEvent {
  final QuerySnapshot<Map<String, dynamic>>? productions;
  final int? pageNumber;
  final int? limit;

  UpdateProductions({
    this.productions,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}