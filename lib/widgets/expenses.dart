import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

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
  
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) =>  NewExpense(onAddExpense:_addExpense,),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("the chart",),
          Expanded(child: ExpensesList(expenses:_registerExpenses ),),
        ],
      ),
    );
  }
}
