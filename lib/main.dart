import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/todo_List_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      home: TodoListScreen(),

    );
  }
}
