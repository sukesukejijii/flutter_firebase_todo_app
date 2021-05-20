import 'package:firebase_setup/api/firebase_api.dart';
import 'package:firebase_setup/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosProvider =
    ChangeNotifierProvider.autoDispose<Todos>((ref) => Todos());

class Todos extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get getTodos => _todos.where((todo) => !todo.isDone).toList();
  List<Todo> get getDone => _todos.where((todo) => todo.isDone).toList();

  void setTodos(List<Todo> todos) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _todos = todos;
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    FirebaseApi.createTodo(todo);
  }

  bool toggleTodo(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void deleteTodo(Todo todo) {
    FirebaseApi.deleteTodo(todo);
  }

  void updateTodo(Todo todo) {
    FirebaseApi.updateTodo(todo);
  }
}
