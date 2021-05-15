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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: ListTile(
          tileColor: Colors.white.withOpacity(0.75),
          hoverColor: Colors.yellow.withOpacity(0.50),
          minVerticalPadding: 20,
          leading: Checkbox(
            fillColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColor,
            ),
            hoverColor: Theme.of(context).accentColor,
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
              style: TextStyle(fontSize: 18),
            ),
          ),
          trailing: IconButton(
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
