import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // list of todo
  final List<Todo> _todoList = [
    // example todo
    Todo(
      todoTitle: 'code challenge',
      isComplete: false,
    ),
    Todo(
      todoTitle: 'bike ride',
      isComplete: false,
    ),
  ];

  // getter -> list of all todo actions
  List<Todo> get todoList => _todoList;

  // method to add todo to todoList
  void addNewTodo(Todo todo) {
    todoList.add(todo);
    notifyListeners();
    print(todo.todoTitle);
  }

  // method to delete todo from todoList
  void deleteTodoItem(int index) {
    todoList.removeAt(index);

    notifyListeners();
  }

  // method to update to isComplete
  void updateCheckbox(bool? value, int index) {
    _todoList[index].isComplete = !_todoList[index].isComplete;
    notifyListeners();
  }
}
