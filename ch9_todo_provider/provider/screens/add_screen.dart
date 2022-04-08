import 'package:flutter/material.dart';
import 'package:flutter_lab/ch9_todo_provider/provider/models/todo.dart';
import 'package:flutter_lab/ch9_todo_provider/provider/providers/todos_model.dart';

import 'package:provider/provider.dart';



class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final controller = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onAdd() {
    //add........................................
    //유저 입력데이터 받아서.. provider 데이터 변경...
    final String title = controller.text;
    final bool completed = completedStatus;
    if(title.isNotEmpty){
      final Todo todo = Todo(title: title, completed: completed);
      //listen : 값 변경시키면서.. 나를 다시 빌드 해야 하는지...
      Provider.of<TodoModel>(context, listen: false).addTodo(todo);
      //화면을 자동으로 이전으로...
      Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(controller: controller),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                          completedStatus = checked ?? false;
                        }),
                    title: Text('Complete?'),
                  ),
                  RaisedButton(
                    child: Text('Add'),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
