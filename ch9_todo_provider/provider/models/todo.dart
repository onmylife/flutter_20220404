import 'package:flutter/material.dart';

//업무 데이터 추상화..  vo
class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}


