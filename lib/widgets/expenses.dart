import 'package:expense_tracker/local_db/expense_database.dart';
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

  ExpenseDatabase expenseDatabase = ExpenseDatabase.instance;
  List<ExpenseModel> _registerExpenses = [
    // ExpenseModel(
    //   title: 'Food Cost',
    //   amount: 120,
    //   date: DateTime.now(),
    //   category: Category.food,
    // ),
    // ExpenseModel(
    //   title: 'Shopping',
    //   amount: 130,
    //   date: DateTime.now(),
    //   category: Category.shopping,
    // )
  ];

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  @override
  dispose() {
    expenseDatabase.close();
    super.dispose();
  }

  refreshNotes() async {
    final value = await expenseDatabase.readAll();
    setState(() {
      _registerExpenses = value;
      print("-------------${_registerExpenses.length}");
    });
  }

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) =>  NewExpense(onAddExpense: refreshNotes,),
    );
    print("----------${_registerExpenses.length}");
  }

  void _removeExpense(ExpenseModel expense){
    expenseDatabase.delete(expense.id!);
      refreshNotes();
    ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //      SnackBar(
    //       content: const Text('Expense deleted'),
    //       duration: const Duration(seconds: 3),
    //       action: SnackBarAction(
    //           label: 'Undo',
    //           onPressed: (){
    //             setState(() {
    //               _registerExpenses.insert(expenseIndex,expense);
    //             });
    //           }
    //       ),
    //     )
    // );
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
