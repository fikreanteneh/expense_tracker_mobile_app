


import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              GoRouter.of(context).pushNamed("/");
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
          // TimeFrameBudget(timeFrame: "groupByDay"),
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
        return ListView.builder(
          itemCount: state.budgets[widget.timeFrame].length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.expenses[widget.timeFrame][index][0]
                        .toString()
                        .substring(0, 11)),
                    Row(
                      children: [
                        Text(state.expenses[widget.timeFrame][index][1]
                            .toString()),
                        Text(state.expenses[widget.timeFrame][index][2]
                            .toString()),
                      ],
                    )
                  ],
                ),
                if (state.expenses[widget.timeFrame][index][3] != null &&
                    state.expenses[widget.timeFrame][index][3].isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        state.expenses[widget.timeFrame][index][3].length,
                    itemBuilder: (context, index1) {
                      String amount = state
                          .expenses[widget.timeFrame][index][3][index1].amount
                          .toString();
                      String type = state
                          .expenses[widget.timeFrame][index][3][index1].type;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              catagory[state
                                  .expenses[widget.timeFrame][index][3][index1]
                                  .category],
                              Text(
                                state
                                    .expenses[widget.timeFrame][index][3]
                                        [index1]
                                    .category
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(type == "income" ? "+$amount" : "-$amount"),
                            ],
                          )
                        ],
                      );
                    },
                  ),
              ],
            );
          },
        );
      } else if (state is ExpenseError) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
