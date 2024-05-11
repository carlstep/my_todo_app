// model to define what a todo is

class Todo {
  String todoTitle;
  String todoDescription;
  bool isComplete;

  Todo({
    required this.todoTitle,
    required this.isComplete,
    required this.todoDescription,
  });
}
