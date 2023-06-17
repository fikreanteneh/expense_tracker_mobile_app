import 'dart:convert';

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
    final result = await http.post(Uri.parse('$uri/expense/post'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "amount": expense.amount,
          "date": expense.date,
          "category": expense.category,
          "user_id": expense.user_id,
          "type": expense.type
        }));
    if (result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create expense');
    }
  }
}
