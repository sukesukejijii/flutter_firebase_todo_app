import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_setup/model/todo.dart';

import '../utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() {
    return FirebaseFirestore.instance
        .collection('todo')
        .orderBy('createdTime')
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson)
            as StreamTransformer<QuerySnapshot, List<Todo>>);
  }

  static Future<void> updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future<void> deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.delete();
  }
}
