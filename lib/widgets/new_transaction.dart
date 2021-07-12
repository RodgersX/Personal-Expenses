import 'package:expense_planner/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountEditingController = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountEditingController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountEditingController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      _titleController.text,
      double.parse(_amountEditingController.text),
      _selectedDate,
    );

    // Closes the modal sheet
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountEditingController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    _submitData(), // accept a value but don't use it. Use underscore
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    // ignore: unnecessary_null_comparison
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                child: Text('Add Transcaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
