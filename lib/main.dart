import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/todo_List_Screen.dart';
import './providers/todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TodoList(),
        ),
        ChangeNotifierProvider.value(
          value: Task(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
            primaryColor: Color(0xff32e0c4),
            accentColor: Color(0xffe8ead3),
            fontFamily: 'TenaliRamakrishna'),
        home: TodoListScreen(),
      ),
    );
  }
}
