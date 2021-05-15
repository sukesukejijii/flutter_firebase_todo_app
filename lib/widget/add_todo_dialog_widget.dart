import 'package:firebase_setup/model/todo.dart';
import 'package:firebase_setup/provider/providers.dart';
import 'package:firebase_setup/provider/todos.dart';
import 'package:firebase_setup/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  final Todo? todo;

  const AddTodoDialogWidget([this.todo]);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      title = widget.todo!.title;
      description = widget.todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    void addTodo() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        final now = DateTime.now();
        final todo = Todo(
          id: now.toString(),
          createdTime: now,
          title: title,
          description: description,
        );

        context.read(todosProvider).addTodo(todo);
        context.read(selectedPageProvider).state = 0;
        Navigator.pop(context);

        Utils.showSnackBar(context, 'New task added');
      }
    }

    void editTodo(Todo todo) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        todo.title = title;
        todo.description = description;

        context.read(todosProvider).updateTodo(todo);
        Navigator.pop(context);

        Utils.showSnackBar(context, 'Task updated');
      }
    }

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.todo == null ? 'Add Todo' : 'Edit Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => this.title = title,
              onChangedDescription: (description) =>
                  this.description = description,
              onSavedTodo: () {
                if (widget.todo == null) {
                  addTodo();
                } else {
                  editTodo(widget.todo!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
