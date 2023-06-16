import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.pushNamed(context, "/addExpense");
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
          TimeFrame(timeFrame: "groupByDay"),
          TimeFrame(timeFrame: "groupByMonth"),
          TimeFrame(timeFrame: "groupByyear"),
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
                return Card(
                  title: Text(state.expenses[index2].name),
                  subtitle: Text(state.expenses[index2].amount.toString()),
                );
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
