part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final Map expenses;

  ExpenseLoaded({required this.expenses});
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError({required this.message});
}
