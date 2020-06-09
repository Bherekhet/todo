import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Globals;
import '../providers/todo_list.dart';

class TodoItem extends StatelessWidget {
  final int id;
  final String task;
  final int isTaskDone;

  TodoItem({this.id, this.task, this.isTaskDone});

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoList>(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.all(4),
        child: IconButton(
          icon: Icon(Icons.delete, color: Colors.white),
          onPressed: () {},
        ),
      ),
      onDismissed: (direction) {
        if (id != null) {
          todo.deleteTask(id);
        }
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    isTaskDone == 1
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    size: 35,
                    color: isTaskDone == 1
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    todo.toggleCompleted(id);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    task,
                    style: isTaskDone == 1
                        ? Globals.tCompletedTodoTask
                        : Globals.tTodoTask,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
