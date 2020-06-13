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

// to record completed tasks i used integers 0 = false and 1 = true, because sqlite doesn't support boolean
class TodoList with ChangeNotifier {
  Map<int, Task> _todos = {};
  var newFormat = DateFormat("MM-dd-yy");

  Map<int, Task> get tasks {
    return {..._todos};
  }

  // this adds new todo item to the list
  void addTodo(title, complete, date) async {
    String updatedDt = newFormat.format(date);

    //instantiate the database
    Database db = await DatabaseHelper.instance.database;

    final int oldId = _todos.keys.toList().last;

    Task newTask = Task(
        id: '${oldId + 1}',
        title: title,
        isComplete: complete,
        date: '$updatedDt');

    //insert into database
    await db.insert(DatabaseHelper.table, newTask.toMap());
    _todos.putIfAbsent(oldId + 1, () => newTask);

    notifyListeners();
  }

  // to change completed tasks respectively
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

  // this deletes swiped task
  void deleteTask(int id) async {
    _todos.remove(id);
    Database db = await DatabaseHelper.instance.database;
    db.delete(DatabaseHelper.table, where: "id = ?", whereArgs: [id]);
    notifyListeners();
  }

  // this fetches all todos from the database
  void getAllTodos() async {
    Database db = await DatabaseHelper.instance.database;

    //get all rows
    List<Map> result = await db.query(DatabaseHelper.table);

    //map each todo object to our list of todos
    result.forEach((element) {
      final index = (element.values.toList()[0]);
      _todos.putIfAbsent(int.parse(index), () => Task.fromJson(element));
    });

    notifyListeners();
  }

  // this counts completed tasks
  int countCompletedTasks(Map<int, Task> tsk) {
    int count = 0;
    tsk.forEach((key, value) {
      if (value.isComplete == 1) {
        count++;
      }
    });
    return count;
  }

  // this sorts tasks based on Date selected by user
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
