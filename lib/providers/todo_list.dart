

class Tasks {
  final String id;
  final String title;

  Tasks(this.id, this.title);
}


class TodoList {
  final String id;
  final String catagory;
  final List<Tasks> tasks;
  
  TodoList(this.id, this.catagory, this.tasks);

  


}