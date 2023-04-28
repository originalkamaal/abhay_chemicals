part of 'production_bloc.dart';

abstract class ProductionState extends Equatable {
  const ProductionState();

  @override
  List<Object> get props => [];
}

class ProductionsLoading extends ProductionState {}

class ProductionsLoaded extends ProductionState {
  final List<Production> productions;

  const ProductionsLoaded({this.productions = const <Production>[]});

  @override
  List<Object> get props => [productions];
}
