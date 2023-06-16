import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpense>((event, emit) => {
      emit(ExpenseInitial())
      try{
        // List<ExpenseDto> expenses = await data.getEx();
        // List<ExpenseDto> budgets = await data.getEx();

        // states = organizer(expenses;)
        // emit(ExpenseLoaded(expenses: states));

      }catch(e){
        emit(ExpenseError(message: e.toString()));
      }
    });

    on<AddExpense>((event, emit) => {});

    on<UpdateExpense>((event, emit) => {});

    on<DeleteExpense>((event, emit) => {});
  }

  organizer(List<ExpenseDto> expenses) {
    Map types = {"expense":1, "income":2};
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

    return {
      'groupByDay': groupByDay,
      'groupByMonth': groupByMonth,
      'groupByYear': groupByYear,
    };
  }
}
}