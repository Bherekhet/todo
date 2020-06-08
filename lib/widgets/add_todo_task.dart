import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_list.dart';

class AddTodoTask extends StatefulWidget {
  @override
  _AddTodoTaskState createState() => _AddTodoTaskState();
}

class _AddTodoTaskState extends State<AddTodoTask> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoList>(context);
    return Form(
      key: _formKey,
      child: AlertDialog(
        actions: <Widget>[
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              if (_formKey.currentState.validate() && _selectedDate!= null) {
                todo.addTodo(_controller.text, false, _selectedDate);
                Navigator.pop(context);
              } else {
                print('date left empty');
              }
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        title: Text('Add task'),
        content: Container(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Task'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                height: 30,
                width: double.infinity,
                child: RaisedButton(
                  color: _selectedDate != null ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
                  child: Text(
                    _selectedDate != null ? '$_selectedDate' : 'Pick a Date',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2222),
                    ).then((value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
