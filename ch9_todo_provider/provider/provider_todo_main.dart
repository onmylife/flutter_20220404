import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'providers/todos_model.dart';
import 'screens/home_screen.dart';



void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //add.................................
    return ChangeNotifierProvider(
        create: (context) => TodoModel(),
        child: MaterialApp(
          home: HomeScreen(),
        ),
    );
  }
}