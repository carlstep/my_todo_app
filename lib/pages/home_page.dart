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
  // text controller for todo name
  final TextEditingController todoNameController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: todoNameController,
                  decoration: const InputDecoration(hintText: 'todo name...'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<TodoProvider>().addNewTodo(
                              Todo(
                                todoTitle: todoNameController.text,
                                isComplete: false,
                              ),
                            );
                        todoNameController.clear();
                        Navigator.of(context).pop();
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

  // edit todo item

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
                  const Text('list of todo actions'),
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.todoList.length,
                        itemBuilder: (context, index) {
                          // provide a list of all todo items
                          Todo eachTodo = value.todoList[index];

                          print(eachTodo.todoTitle);

                          return MyTodoCard(
                            todo: eachTodo,
                            onChanged: (value) => toggleCheckbox(value, index),
                            deleteFunction: (context) => deleteTodo(index),
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
