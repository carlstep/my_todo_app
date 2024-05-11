import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // list of todo
  final List<Todo> _todoList = [
    // example todo
    Todo(
        todoTitle: 'code challenge',
        isComplete: false,
        todoDescription: 'complete the todo app coding challenge...'),
    Todo(
        todoTitle: 'bike ride',
        isComplete: false,
        todoDescription:
            'complete 20km bike ride to improve fitness and clear mind...'),
  ];

  // getter -> list of all todo actions
  List<Todo> get todoList => _todoList;

  // method to add todo to todoList
  void addNewTodo(Todo todo) {
    todoList.add(todo);
    notifyListeners();
  }

  // method to delete todo from todoList
  void deleteTodoItem(int index) {
    todoList.removeAt(index);

    notifyListeners();
  }

  // method to edit existing todo item and save changes
  void updateTodo(int index, String newTitle, String newDescription) {
    todoList[index].todoTitle = newTitle;
    todoList[index].todoDescription = newDescription;
    notifyListeners();
  }

  // method to update to isComplete
  void updateCheckbox(bool? value, int index) {
    _todoList[index].isComplete = !_todoList[index].isComplete;
    notifyListeners();
  }
}
