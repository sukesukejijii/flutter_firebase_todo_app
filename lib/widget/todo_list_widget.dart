import 'package:firebase_setup/provider/providers.dart';
import 'package:firebase_setup/provider/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  final int selectedIndex;

  TodoListWidget(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: Center(
        child: Text(
          selectedIndex == 0
              ? 'All Tasks Completed!!'
              : 'No Completed Tasks...',
          style: TextStyle(fontSize: 20),
        ),
      ),
      builder: (context, watch, child) {
        final todos = selectedIndex == 0
            ? watch(todosProvider).getTodos
            : watch(todosProvider).getDone;

        if (todos.isEmpty) {
          return child!;
        }

        return Scrollbar(
          controller: context.read(scrollControllerProvider),
          thickness: 12,
          isAlwaysShown: true,
          child: ListView.separated(
            controller: context.read(scrollControllerProvider),
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoWidget(todo: todos[index]),
            separatorBuilder: (context, index) => Container(height: 18),
            padding: EdgeInsets.all(16),
          ),
        );
      },
    );
  }
}
