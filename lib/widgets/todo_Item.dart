import 'package:flutter/material.dart';

import '../constants.dart' as Globals;

class TodoItem extends StatelessWidget {
  final int id;
  final String task;
  final bool isTaskDone;

  TodoItem({this.id, this.task, this.isTaskDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          // color: Colors.red,
          child: ListTile(
            leading:
                Icon(isTaskDone ? Icons.check_box : Icons.check_box_outline_blank),
            title: Text(
              task,
              style: isTaskDone ? Globals.tCompletedTodoTask : Globals.tTodoTask,
            ),
            subtitle: Text(
                '${DateTime.now().month}/ ${DateTime.now().day}/ ${DateTime.now().year} '),
            trailing: Icon(Icons.delete),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
        // Divider(indent: 40, endIndent: 40, thickness: 2,)
      ],
    );
    // Row(
    //   children: <Widget>[
    //     IconButton(
    //       color: isTaskDone ? Colors.grey : null,
    //       icon: Icon(
    //           isTaskDone ? Icons.check_box : Icons.check_box_outline_blank),
    //       onPressed: () {},
    //     ),
    //     SizedBox(
    //       width: 10,
    //     ),
    //     Container(

    //       child: Text(task, style: isTaskDone ? Globals.tCompletedTodoTask : Globals.tTodoTask,),
    //     )
    //   ],
    // );
  }
}
