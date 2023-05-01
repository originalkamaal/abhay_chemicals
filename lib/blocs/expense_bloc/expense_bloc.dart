import 'dart:async';

import 'package:abhay_chemicals/controllers/expense_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseController _expenseController;
  StreamSubscription? _productSubscription;

  ExpenseBloc({required ExpenseController expenseController})
      : _expenseController = expenseController,
        super(ExpenseLoading()) {
    on<LoadExpense>(_mapLoadExpenseToState);
    on<UpdateExpense>(_mapUpdateExpenseToState);
    // on<LoadNextExpense>(_mapLoadNextExpenseToState);
  }

  _mapLoadExpenseToState(LoadExpense event, Emitter<ExpenseState> emit) async {
    _productSubscription?.cancel();

    int limit = event.limit;

    if (event.lastDoc == null) {
      _productSubscription = _expenseController
          .getAllExpenses(limit: limit, action: event.direction)
          .listen((expense) {
        add(UpdateExpense(expense: expense, pageNumber: 1, limit: limit));
      });
    } else {
      print("Last doc is there");
      _productSubscription = _expenseController
          .getAllExpenses(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((expense) {
        add(UpdateExpense(
            expense: expense,
            pageNumber: event.direction == 1
                ? event.pageNumber + 1
                : event.pageNumber - 1,
            limit: event.limit));
      });
    }
  }

  _mapUpdateExpenseToState(
      UpdateExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoaded(
        expense: event.expense,
        hasMore: (event.expense!.docs.length == event.limit),
        pageNumber: event.pageNumber!,
        limit: event.limit!));
  }

  // _mapLoadNextExpenseToState(
  //     LoadNextExpense event, Emitter<ExpenseState> emit) async {
  //   _productSubscription?.cancel();

  //   _productSubscription = _expenseController
  //       .getNextExpense(event.snap)!
  //       .listen((Expense) {
  //     add(UpdateExpense(Expense));
  //   });
  // }
}
