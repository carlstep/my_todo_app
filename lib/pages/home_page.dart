import 'package:flutter/material.dart';

import 'package:my_todo_app/components/my_todo_card.dart';
import 'package:my_todo_app/models/todo_provider.dart';
import 'package:my_todo_app/models/todo_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller for todo title
  final TextEditingController todoTitleController = TextEditingController();
  // text controller for todo description
  final TextEditingController todoDescriptionController =
      TextEditingController();

  // method to add new todo
  void addNewTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  controller: todoTitleController,
                  decoration: const InputDecoration(hintText: 'todo name...'),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 140,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    minLines: 3,
                    maxLines: 5,
                    controller: todoDescriptionController,
                    decoration:
                        const InputDecoration(hintText: 'todo description...'),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<TodoProvider>().addNewTodo(
                              Todo(
                                todoTitle: todoTitleController.text,
                                todoDescription: todoDescriptionController.text,
                                isComplete: false,
                              ),
                            );

                        Navigator.of(context).pop();
                        todoTitleController.clear();
                        todoDescriptionController.clear();
                      },
                      child: const Text('save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // delete todo item
  void deleteTodo(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: SizedBox(
          height: 100,
          width: 300,
          child: Column(
            children: [
              const Text(
                'Confirm to delete the task?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: SizedBox(
                  height: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<TodoProvider>(context, listen: false)
                          .deleteTodoItem(index);

                      Navigator.of(context).pop();
                      todoTitleController.clear();
                      todoDescriptionController.clear();
                    },
                    child: const Text('delete'),
                  ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }

  // toggle check box
  void toggleCheckbox(bool? value, int index) {
    Provider.of<TodoProvider>(context, listen: false)
        .updateCheckbox(value, index);
  }

  // function >> edit existing todo item
  void editTodo(int index) {
    // retrieve the todoList
    final todoList = Provider.of<TodoProvider>(context, listen: false);
    // access the specific todo item
    final todo = todoList.todoList[index];

    print('edit $index');
    todoTitleController.text = todo.todoTitle;
    todoDescriptionController.text = todo.todoDescription;

    // display todo data[index] >> enter new todo data >> save new data to todo[index]
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'edit todo item',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    // displays the exisitng todoTitle
                    controller: todoTitleController,
                  ),
                  TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    minLines: 3,
                    maxLines: 5,
                    // displays the exisitng todoDescription
                    controller: todoDescriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        // cancel button, changes not saved, controllers cleared
                        onPressed: () {
                          Navigator.pop(context);
                          todoTitleController.clear();
                          todoDescriptionController.clear();
                        },
                        child: const Text('cancel'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        // changes made to todoTitleController saved to newTitle
                        // changes made to todoDescriptionController saved to newDescription
                        onPressed: () {
                          final newTitle = todoTitleController.text;
                          final newDescription = todoDescriptionController.text;
                          // index, newTitle, newDescription >> passed thru to todoList.updateTodo
                          todoList.updateTodo(index, newTitle, newDescription);

                          Navigator.pop(context);
                          // clears the controllers
                          todoTitleController.clear();
                          todoDescriptionController.clear();
                        },
                        child: const Text('save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  // share todo item to calendar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text(
          'My Todo List',
        ),
      ),
      // body displays ActiveTodoPage, but will have option to display completed todo
      body: Consumer<TodoProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.todoList.length,
                        itemBuilder: (context, index) {
                          // provide a list of all todo items
                          Todo eachTodo = value.todoList[index];

                          return MyTodoCard(
                            todo: eachTodo,
                            onChanged: (value) => toggleCheckbox(value, index),
                            deleteFunction: (context) => deleteTodo(index),
                            editFunction: (context) => editTodo(index),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // fab -> create new todo
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
