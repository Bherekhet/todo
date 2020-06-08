import 'package:flutter/cupertino.dart';

// Map<String, Tasks> _tasks = {
//   0,
//   Tasks(
//     id: '90',
//     title: 'go for a swim',
//     isComplete: true,
//     dateTime: DateTime.now(),
//   ),
//   Tasks(
//     id: '50',
//     title: 'go for a swim',
//     isComplete: false,
//     dateTime: DateTime.now(),
//   ),
// };



class Tasks with ChangeNotifier{
  final String id;
  final String title;
  bool isComplete = false;
  final DateTime dateTime;

  Tasks({this.id, this.title, this.dateTime, this.isComplete});

  void toggleCompleted(String id) {
    isComplete = !isComplete;
    notifyListeners();
  }
}

class TodoList with ChangeNotifier {
  Map<String, Tasks> _todos = {};

  Map<String, Tasks> get tasks {
    return {..._todos};
  }

  void addTodo(title, complete, date) {
    if (date!= null) {
      String value = '${_todos.length}';
      _todos['$value'] = Tasks(id: value, title: title, isComplete: false, dateTime: date);
    }
    notifyListeners();
  }

  void toggleCompleted(String id) {
    _todos.values.toList()[int.parse(id)].isComplete = !_todos.values.toList()[int.parse(id)].isComplete;
    notifyListeners();
  }

  void deleteTask(String id) {
    _todos.remove(id);
    notifyListeners();
  }

  void sortTodoOnDate() {
    
    notifyListeners();
  }

  
}
