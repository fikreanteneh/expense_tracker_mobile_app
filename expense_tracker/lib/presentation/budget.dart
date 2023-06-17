import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    final authBloc = BlocProvider.of<LoginCubit>(context);
    expenseBloc.add(LoadExpense(id: authBloc.state.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push("/home/addbudget");
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: const Text(
            "Expense Tracker",
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Monthly",
            ),
            Tab(
              text: "Yearly",
            )
          ]),
        ),
        body: const TabBarView(children: [
          TimeFrameBudget(timeFrame: "groupByMonth"),
          TimeFrameBudget(timeFrame: "groupByYear"),
        ]),
      ),
    );
  }
}

class TimeFrameBudget extends StatefulWidget {
  final String timeFrame;
  const TimeFrameBudget({Key? key, required this.timeFrame}) : super(key: key);

  @override
  State<TimeFrameBudget> createState() => _TimeFrameBudgetState();
}

class _TimeFrameBudgetState extends State<TimeFrameBudget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      if (state is ExpenseLoaded) {
        List items = state.budgets[widget.timeFrame];
        return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMM().format(items[index].date),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("amount ${items[index].amount.toString()}"),
                    Text("expense ${items[index].expense.toString()}"),
                  ],
                ),
              );
            });

        return Column();
      } else if (state is ExpenseError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
