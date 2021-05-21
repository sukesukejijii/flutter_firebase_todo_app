import 'package:firebase_setup/provider/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  final int selectedTab;

  TodoListWidget(this.selectedTab);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: Center(
        child: Text(
          selectedTab == 0 ? 'All Tasks Completed!!' : 'No Completed Tasks...',
          style: TextStyle(fontSize: 20),
        ),
      ),
      builder: (context, watch, child) {
        final todos = selectedTab == 0
            ? watch(todosProvider).getTodos
            : watch(todosProvider).getDone;

        if (todos.isEmpty) {
          return child!;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                children: [
                  for (var todo in todos) TodoWidget(todo: todo),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
