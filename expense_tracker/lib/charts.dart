import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/bar_chart.dart';
import 'package:expense_tracker/category_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    final authBloc = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).pushNamed("/addExpense");
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "categories",
            ),
            Tab(
              text: "statistics",
            ),
          ]),
        ),
        body: TabBarView(children: [
          const PieChartCategory(),
          BarChartPage(),
        ]),
      ),
    );
  }
}
