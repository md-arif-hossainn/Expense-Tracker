import 'package:flutter/material.dart';
class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  ///we dont use that its kind of hassle for set data we use controller
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _presentDatePicker() {

    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
           TextField(
            maxLength: 50,
           // onChanged: _saveTitleInput,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              const SizedBox(width: 16,),
               Expanded(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Selected Date'),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                               ),
               )

            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')
              ),
              ElevatedButton(
                  onPressed: (){
                    print(_titleController.text);
                  },
                   child: const Text('Save Expense'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

