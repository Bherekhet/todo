import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/add_todo_task.dart';
import '../providers/todo_list.dart';
import '../widgets/todo_Item.dart';
import '../constants.dart' as Globals;

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  bool _isnit = false;
  final currentDate = DateTime.now();
  bool perDate = false;
  DateTime selectedDate;

  @override
  void initState() {
    _isnit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isnit) {
      if (this.mounted) {
        Provider.of<TodoList>(context).getAllTodos();
        setState(() {
          _isnit = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final currentDay = DateFormat('EEEE').format(currentDate);
    final formattedDate = DateFormat('MMMM d, yyyy').format(currentDate);
    final todo = Provider.of<TodoList>(context);
    final tasks = perDate ? todo.sortTaskPerDate(selectedDate) : todo.tasks;

    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      (perDate) ? DateFormat('MMMM d, yyyy').format(selectedDate) :formattedDate,
                      style: Globals.tScreenTitleDate,
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    margin: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Text(
                         (perDate) ? DateFormat('EEEE').format(selectedDate):currentDay,
                          style: Globals.tScreenTitleDay,
                        ),
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2222),
                      ).then((value) {
                        if(value != null){
                          setState(() {
                          selectedDate = value;
                          perDate = true;
                        });
                        }
                        
                      });
                    },
                  ),
                ],
              ),
              Divider(
                endIndent: 50,
                indent: 50,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    'You have ${todo.countCompletedTasks(tasks)} tasks completed.'),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Your Todos',
                    style: Globals.tTodoCatagory,
                  )),
              tasks.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TodoItem(
                          id: tasks.keys.toList()[i],
                          task: tasks.values.toList()[i].title,
                          isTaskDone: tasks.values.toList()[i].isComplete,
                        ),
                      ),
                    )
                  : Center(child: Text('Your todo list is empty')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AddTodoTask();
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
