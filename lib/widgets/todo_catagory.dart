import 'package:flutter/material.dart';

import '../constants.dart' as Globals;

class TodoCatagory extends StatelessWidget {
  final String id;
  final String catagory;

  TodoCatagory({this.id, this.catagory});
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          alignment: Alignment.topLeft,
          child: Text(catagory, style: Globals.tTodoCatagory,),
        ),
        
      ],
    );
  }
}