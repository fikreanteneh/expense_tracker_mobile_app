import 'package:expense_tracker/application/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/presentation/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  void initState() {
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    super.initState();
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final _addServiceKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Expense"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addServiceKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _title,
                hintText: "Title",
                validation: "Enter title",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _description,
                hintText: "Desscription",
                maxLines: 7,
                validation: "Enter description",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _price,
                hintText: "Amount",
                validation: "Enter Amount",
                keyBoard: true,
              ),
              const SizedBox(
                height: 40,
              ),
              // Center(
              //   child: CustomButton(
              //     color: GlobalVariables.primaryColor,
              //     text: "Done",
              //     onTap: () {
              //       if (_addServiceKey.currentState!.validate()) {
              //         BlocProvider.of<ServicesBloc>(context).add(
              //           AddService(
              //             token: BlocProvider.of<LoginCubit>(context)
              //                 .state
              //                 .user
              //                 .token,
              //             service: Service(
              //               doctor_id: BlocProvider.of<LoginCubit>(context)
              //                   .state
              //                   .user
              //                   .id,
              //               title: _title.text,
              //               description: _description.text,
              //               price: double.parse(_price.text),
              //             ),
              //           ),
              //         );
              //         GoRouter.of(context).pop();
              //       }
              //     },
              //   ),
              // )
            ]),
          ),
        ),
      ),
    );
  }
}
