import 'package:bloc/bloc.dart';
import 'package:expense_tracker/application/expense.dto.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpense>((event, emit) => {});

    on<AddExpense>((event, emit) => {});

    on<UpdateExpense>((event, emit) => {});

    on<DeleteExpense>((event, emit) => {});
  }
}
