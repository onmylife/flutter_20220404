import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/todo.dart';

//값 변경 하위 전파되게 하기 위해서...
class TodoModel extends ChangeNotifier {
  List<Todo> todos = [];

  void addTodo(Todo todo){
    todos.add(todo);
    notifyListeners();
  }
  void toggleTodo(Todo todo){
    final index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }
  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}

