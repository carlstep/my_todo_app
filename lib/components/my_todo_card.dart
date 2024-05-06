// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:my_todo_app/models/todo_model.dart';

class MyTodoCard extends StatelessWidget {
  final Todo todo;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  MyTodoCard({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              // edit todo item function
              // edit todo item variables and save
              borderRadius: BorderRadius.circular(10),
              onPressed: null,
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              label: 'edit',
            ),
            SlidableAction(
              // share todo item function -> add to calendar
              borderRadius: BorderRadius.circular(10),
              onPressed: null,
              icon: Icons.share,
              backgroundColor: Colors.green,
              label: 'share',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              // delete todo item function
              borderRadius: BorderRadius.circular(10),
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'delete',
            ),
          ],
        ),
        child: Card(
          color: todo.isComplete ? Colors.green.shade100 : Colors.grey.shade200,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    // the todo title
                    Text(
                      todo.todoTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: todo.isComplete
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    // checkbox - isComplete - true / false
                    Checkbox(
                      value: todo.isComplete,
                      onChanged: onChanged,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
