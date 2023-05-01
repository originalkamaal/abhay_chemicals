part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final QuerySnapshot<Map<String, dynamic>>? expense;
  final int limit;
  final int pageNumber;
  final bool hasMore;
  const ExpenseLoaded(
      {this.expense,
      this.limit = 10,
      this.hasMore = true,
      this.pageNumber = 1});

  @override
  List<Object> get props => [expense!, limit];
}
