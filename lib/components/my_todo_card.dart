// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:my_todo_app/models/todo_model.dart';

class MyTodoCard extends StatefulWidget {
  final Todo todo;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext?)? editFunction;

  const MyTodoCard({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  State<MyTodoCard> createState() => _MyTodoCardState();
}

class _MyTodoCardState extends State<MyTodoCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                // edit todo item function
                // edit todo item variables and save
                borderRadius: BorderRadius.circular(10),
                onPressed: widget.editFunction,
                icon: Icons.edit,
                backgroundColor: Colors.blue,
                label: 'edit',
              ),
              SlidableAction(
                // share todo item function -> e.g. add details to calendar
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
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                label: 'delete',
              ),
            ],
          ),
          child: Card(
            color: widget.todo.isComplete
                ? Colors.green.shade100
                : Colors.grey.shade200,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // the todo title
                      Text(
                        widget.todo.todoTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: widget.todo.isComplete
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
                        value: widget.todo.isComplete,
                        onChanged: widget.onChanged,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // three dots to indicate there are todo notes
                      widget.todo.todoDescription.isNotEmpty
                          ? const Icon(Icons.more_horiz_outlined)
                          : const SizedBox(),
                      const Expanded(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      // number of days to deadline date
                      const Text('-6'),
                      const SizedBox(
                        width: 10,
                      ),
                      // deadline date - set by the user when creating new todo
                      const Text('15/05/2024'),
                    ],
                  ),
                  // TODO - make the width of the text box expand to width of container
                  Container(
                    color: Colors.white,
                    // text for todoDescription is displayed when card is tapped to expanded view
                    child: _isExpanded
                        ? Text(
                            widget.todo.todoDescription,
                            style: const TextStyle(fontSize: 18),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
