import 'package:expense_tracker/expenses_list.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}
class _ExpensesState extends State<Expenses> {

  final List<Expense> _registerExpenses = [
    Expense(
      title: 'tyeg',
      amount: 250,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'tyeguhijopg',
      amount: 50,
      date: DateTime.now(),
      category: Category.travel,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("rytuihijokp"),
          Expanded(child: ExpensesList(expenses:_registerExpenses ),),
        ],
      ),
    );
  }
}
