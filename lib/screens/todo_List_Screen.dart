import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_todo_task.dart';
import '../providers/todo_list.dart';
import '../widgets/todo_Item.dart';
import '../constants.dart' as Globals;

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TodoList>(context).tasks;
    print('error caused $tasks');
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
                      'June 6th, 2020',
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
                      child: Text(
                        'Monday',
                        style: Globals.tScreenTitleDay,
                      ),
                    ),
                    onTap: () {
                      print('day selected');
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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Your Todos',
                    style: Globals.tTodoCatagory,
                  )),
              tasks.isNotEmpty ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TodoItem(
                    id: tasks.keys.toList()[i],
                    task: tasks.values.toList()[i].title,
                    isTaskDone: tasks.values.toList()[i].isComplete,
                  ),
                ),
              ): Center(child: Text('Your todo list is empty')),
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
            showDialog(context: context, builder: (BuildContext ctx) {
              return AddTodoTask();
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
