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
    // _todos.add(todo);
    // notifyListeners();

    FirebaseApi.createTodo(todo);
  }

  bool toggleTodo(Todo todo) {
    // todo.isDone = !todo.isDone;
    // notifyListeners();

    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void deleteTodo(Todo todo) {
    // _todos.remove(todo);
    // notifyListeners();

    FirebaseApi.deleteTodo(todo);
  }

  void updateTodo(Todo todo) {
    // final todoIndex = _todos.indexWhere((t) => t.id == todo.id);
    // _todos.replaceRange(todoIndex, todoIndex + 1, [todo]);
    // notifyListeners();

    FirebaseApi.updateTodo(todo);
  }
}
