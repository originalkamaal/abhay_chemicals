part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpense extends ExpenseEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;
  final String direction;
  final int pageNumber;

  LoadExpense(
      {this.lastDoc,
      this.limit = 10,
      this.direction = "init",
      this.pageNumber = 1});
}

class UpdateExpense extends ExpenseEvent {
  final QuerySnapshot<Map<String, dynamic>>? expense;
  final int? pageNumber;
  final int? limit;

  UpdateExpense({
    this.expense,
    this.pageNumber,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
