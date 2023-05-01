part of 'production_bloc.dart';

abstract class ProductionEvent extends Equatable {
  const ProductionEvent();

  @override
  List<Object> get props => [];
}

class LoadProductions extends ProductionEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  LoadProductions(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
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
