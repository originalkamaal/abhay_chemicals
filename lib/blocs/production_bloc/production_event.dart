part of 'production_bloc.dart';

abstract class ProductionEvent extends Equatable {
  const ProductionEvent();

  @override
  List<Object> get props => [];
}

class LoadProductions extends ProductionEvent {}

class UpdateProductions extends ProductionEvent {
  final List<Production> productions;

  UpdateProductions(this.productions);

  @override
  List<Object> get props => [];
}
