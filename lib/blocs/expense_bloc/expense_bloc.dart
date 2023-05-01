import 'dart:async';

import 'package:abhay_chemicals/controllers/expense_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      _productSubscription = _expenseController
          .getAllExpenses(
              lastDoc: event.lastDoc, limit: limit, action: event.direction)
          .listen((expense) {
        add(UpdateExpense(
            expense: expense,
            pageNumber: event.direction == "forward"
                ? event.pageNumber + 1
                : event.direction == "back"
                    ? event.pageNumber - 1
                    : event.pageNumber,
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
