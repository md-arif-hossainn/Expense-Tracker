import 'package:expense_tracker/widgets/chart/chart.dart';
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
      title: 'Work',
      amount: 60,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Travel',
      amount: 90,
      date: DateTime.now(),
      category: Category.travel,
    )
  ];
  
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
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

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: const Text('Expense deleted'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: (){
                setState(() {
                  _registerExpenses.insert(expenseIndex,expense);
                });
              }
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(child: Text('No expense found. Start adding some!'),);

    if(_registerExpenses.isNotEmpty){
      mainContent = ExpensesList(
        expenses:_registerExpenses ,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registerExpenses),
          Expanded(child: mainContent
          ),
        ],
      ) : Row(
        children: [
          Expanded(child: Chart(expenses: _registerExpenses)),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
