import 'package:flutter/cupertino.dart';
import './database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  int isComplete = 0;
  final String date;

  Task({this.id, this.title, this.date, this.isComplete});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isComplete': isComplete,
      'date': date,
    };
  }

  factory Task.fromJson(Map<String, dynamic> parsedJson) {
    return Task(
      id: parsedJson['id'],
      title: parsedJson['title'],
      isComplete: parsedJson['isComplete'],
      date: parsedJson['date'],
    );
  }
}

class TodoList with ChangeNotifier {
  Map<int, Task> _todos = {};
  var newFormat = DateFormat("MM-dd-yy");

  Map<int, Task> get tasks {
    return {..._todos};
  }

  void addTodo(title, complete, date) async {
    String updatedDt = newFormat.format(date);

    //instantiate the database
    Database db = await DatabaseHelper.instance.database;

    //create an id based on the last id used, +1
    final int newId = _todos.keys.toList().last;

    Task newTask = Task(
        id: '${newId + 1}',
        title: title,
        isComplete: complete,
        date: '$updatedDt');

    //insert into database
    await db.insert(DatabaseHelper.table, newTask.toMap());
    _todos.putIfAbsent(newId + 1, () => newTask);

    notifyListeners();
  }

  void toggleCompleted(int id) async {
    Database db = await DatabaseHelper.instance.database;
    _todos.update(id, (existingValue) {
      return Task(
          id: existingValue.id,
          title: existingValue.title,
          isComplete: existingValue.isComplete == 0 ? 1 : 0,
          date: existingValue.date);
    });
    db.update(DatabaseHelper.table, _todos[id].toMap(),
        where: "id = ?",
        whereArgs: [id]);
    notifyListeners();
  }

  void deleteTask(int id) async {
    print(_todos[id]);
    _todos.remove(id);
    Database db = await DatabaseHelper.instance.database;
    db.delete(DatabaseHelper.table, where: "id = ?", whereArgs: [id]);
    notifyListeners();
  }

  void getAllTodos() async {
    Database db = await DatabaseHelper.instance.database;

    //get all rows
    List<Map> result = await db.query(DatabaseHelper.table);

    //map each todo object to our list of todos
    result.forEach((element) {
      final index = (element.values.toList()[0]);
      _todos.putIfAbsent(int.parse(index), () => Task.fromJson(element));
    });

    result.forEach((element) {
      print('db rows : $element');
    });
    notifyListeners();
  }

  int countCompletedTasks(Map<int, Task> tsk) {
    int count = 0;
    tsk.forEach((key, value) {
      if (value.isComplete == 1) {
        count++;
      }
    });
    return count;
  }

  Map<int, Task> sortTaskPerDate(DateTime date) {
    //get the right format of date in string 'mm-dd-yyyy'
    String updatedDt = newFormat.format(date);
    Map<int, Task> newMap = {}; //new map for holding the sorted todo list

    //map every todo list for the selected specific date
    _todos.forEach((key, value) {
      if (value.date == updatedDt) {
        newMap.putIfAbsent(key, () => value);
      }
    });
    return newMap;
  }
}
