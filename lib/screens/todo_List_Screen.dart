import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/todo_catagory.dart';
import '../widgets/todo_Item.dart';
import '../constants.dart' as Globals;

List _tasks = [
  {
    'id': 0,
    'catagory': 'Activity',
    'tasks': [
      'play soccer',
      'go for a swim',
    ],
    'date': DateTime.now(),
  },
  {
    'id': 1,
    'catagory': 'Study',
    'tasks': [
      'Algorithms',
      'todo app',
    ],
    'date': DateTime.now(),
  },
];

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.only(top: 10),
              //   alignment: Alignment.topCenter,
              //   child: Text('Your todo list', style: Globals.tTodoListTitle,),
              // ),
              TodoCatagory(
                  id: _tasks[0]['id'], catagory: _tasks[0]['catagory']),
              
              TodoItem(
                id: _tasks[0]['id'],
                task: _tasks[0]['tasks'][0],
                isTaskDone: false,
              ),
              TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),
              TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),

              TodoCatagory(
                  id: _tasks[1]['id'], catagory: _tasks[1]['catagory']),
              
              TodoItem(
                id: _tasks[0]['id'],
                task: _tasks[0]['tasks'][0],
                isTaskDone: false,
              ),
              TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),
              TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),
              TodoItem(
                id: _tasks[1]['id'],
                task: _tasks[1]['tasks'][1],
                isTaskDone: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
