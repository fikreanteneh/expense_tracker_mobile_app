import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/application/expense_bloc/expense_fetcher.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpense>(_onLoadExpense);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(__onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
  }

  FutureOr<void> _onLoadExpense(
      LoadExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseInitial());
    try {
      print("======== expense fetching");
      List<ExpenseDto> expenses = await ExpenseFetcher.getExpense(event.id);
      print("========${expenses.length}");
      print("======== expense fetching finished");

      Map organized = organizer(expenses);
      emit(ExpenseLoaded(expenses: organized));
    } catch (e) {
      emit(ExpenseError(message: e.toString()));
    }
  }

  FutureOr<void> _onAddExpense(AddExpense event, Emitter<ExpenseState> emit) {}

  FutureOr<void> __onUpdateExpense(
      UpdateExpense event, Emitter<ExpenseState> emit) {}

  FutureOr<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) {}

  Map organizer(List<ExpenseDto> expenses) {
    Map types = {"expense": 1, "income": 2};
    // Map indexDays = {};
    List groupByDay = [];
    List groupByMonth = [];
    List groupByYear = [];
    expenses.sort((a, b) => a.date.compareTo(b.date));
    int lastDay = -1;
    int lastMonth = -1;
    int lastYear = -1;

    for (var expense in expenses) {
      int dateNumber = expense.date.day;
      int monthNumber = expense.date.month;
      int yearNumber = expense.date.year;

      DateTime daily = DateTime(yearNumber, monthNumber, dateNumber);
      DateTime monthly = DateTime(yearNumber, monthNumber);
      DateTime yearly = DateTime(yearNumber);

      if (groupByDay.isNotEmpty && groupByDay[0][0] == daily) {
        groupByDay[lastDay][types[expense.category]] += expense.amount;
        groupByDay[lastDay][3].add(expense);
      } else {
        groupByDay.add([
          daily,
          expense.amount,
          [expense]
        ]);
        lastDay++;
      }

      if (groupByMonth.isNotEmpty || groupByMonth[0][0] == monthly) {
        groupByMonth[lastMonth][types[expense.category]] += expense.amount;
        groupByMonth[lastMonth][3].add(expense);
      } else {
        groupByMonth.add([
          monthly,
          expense.amount,
          [expense]
        ]);
        lastMonth++;
      }

      if (groupByYear.isNotEmpty || groupByYear[0][0] == yearly) {
        groupByYear[lastYear][types[expense.category]] += expense.amount;
        groupByYear[lastYear][3].add(expense);
      } else {
        groupByYear.add([
          yearly,
          expense.amount,
          [expense]
        ]);
        lastYear++;
      }
    }
    return {
      'groupByDay': groupByDay,
      'groupByMonth': groupByMonth,
      'groupByYear': groupByYear,
    };
  }
}
