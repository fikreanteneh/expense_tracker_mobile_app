import 'dart:convert';

import 'package:expense_tracker/budget.dto.dart';
import 'package:expense_tracker/expense.dto.dart';
import 'package:expense_tracker/utils.dart';
import 'package:http/http.dart' as http;

class ExpenseFetcher {
  static Future<List<ExpenseDto>> getExpense(int id) async {
    final result = await http.get(Uri.parse('$uri/expense/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (result.statusCode == 200) {
      List json = jsonDecode(result.body);
      final expenses = json.map((e) => ExpenseDto.fromMap(e)).toList();
      return expenses;
    } else {
      throw Exception('Failed to load expense');
    }
  }

  static Future<bool> addExpense(ExpenseDto expense) async {
    final result = await http.post(Uri.parse('$uri/expense/create'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "amount": expense.amount,
          "category": expense.category,
          "date": expense.date.toIso8601String(),
          "user_id": expense.user_id,
          "type": expense.type,
        }));

    if (result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add expense');
    }
  }

  static Future<List<BudgetDto>> getBudget(int id) async {
    final result = await http.get(Uri.parse('$uri/budget/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (result.statusCode == 200) {
      List json = jsonDecode(result.body);
      final budget = json.map((e) => BudgetDto.fromMap(e)).toList();
      return budget;
    } else {
      throw Exception('Failed to load budgets');
    }
  }

  static Future<bool> addBudjet(BudgetDto budget) async {
    final result = await http.post(
      Uri.parse('$uri/expense/createbudget'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(
        {
          "amount": budget.amount,
          "date": budget.date.toIso8601String(),
          "user_id": budget.user_id,
          "type": budget.type,
        },
      ),
    );

    if (result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create expense');
    }
  }
}
