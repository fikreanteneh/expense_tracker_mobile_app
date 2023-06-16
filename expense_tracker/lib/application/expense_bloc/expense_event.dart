part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}

class LoadExpense extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final ExpenseDto expense;
  AddExpense({required this.expense});
}

class UpdateExpense extends ExpenseEvent {
  final ExpenseDto expense;
  UpdateExpense({required this.expense});
}

class DeleteExpense extends ExpenseEvent {
  final ExpenseDto expense;
  DeleteExpense({required this.expense});
}
