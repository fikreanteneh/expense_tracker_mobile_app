import 'package:expense_tracker/application/auth/login/login_cubit.dart';
import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    final authBloc = BlocProvider.of<LoginCubit>(context);
    expenseBloc.add(LoadExpense(id: authBloc.state.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              text: "Daily",
            ),
            Tab(
              text: "Monthly",
            ),
            Tab(
              text: "Yearly",
            )
          ]),
        ),
        body: const TabBarView(children: [
          Text("daily"),
          Text("daily"),
          Text("daily")

          // TimeFrame(timeFrame: "groupByDay"),
          // TimeFrame(timeFrame: "groupByMonth"),
          // TimeFrame(timeFrame: "groupByyear"),
        ]),
      ),
    );
  }
}

class TimeFrame extends StatefulWidget {
  final String timeFrame;
  const TimeFrame({Key? key, required this.timeFrame}) : super(key: key);

  @override
  _TimeFrameState createState() => _TimeFrameState();
}

class _TimeFrameState extends State<TimeFrame> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
      if (state is ExpenseLoaded) {
        return ListView.builder(
          itemCount: state.expenses[widget.timeFrame].length,
          itemBuilder: (context, index) {
            return Container(
              child: ListView.builder(itemBuilder: (context, index2) {
                return Card();
              }),
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
