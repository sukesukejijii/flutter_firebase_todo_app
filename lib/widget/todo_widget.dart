import 'package:firebase_setup/model/todo.dart';
import 'package:firebase_setup/provider/todos.dart';
import 'package:firebase_setup/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_todo_dialog_widget.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(9),
      child: Container(
        width: 360,
        height: 240,
        child: ListTile(
          tileColor: Colors.white.withOpacity(0.75),
          hoverColor: Colors.yellow.withOpacity(0.15),
          minVerticalPadding: 20,
          leading: Checkbox(
            hoverColor: Colors.yellow,
            value: todo.isDone,
            onChanged: (_) {
              context.read(todosProvider).toggleTodo(todo);
              Utils.showSnackBar(
                context,
                todo.isDone ? 'Task Completed' : 'Task Resumed',
              );
            },
          ),
          title: Text(
            todo.title,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 22,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              todo.description,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 18),
            ),
          ),
          trailing: IconButton(
            tooltip: 'Delete Task',
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read(todosProvider).deleteTodo(todo);
              Utils.showSnackBar(context, 'Task Deleted');
            },
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AddTodoDialogWidget(todo),
          ),
        ),
      ),
    );
  }
}
