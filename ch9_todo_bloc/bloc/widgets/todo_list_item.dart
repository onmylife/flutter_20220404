import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todosBloc.dart';
import '../events/events.dart';
import '../states/todosState.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    //add.....................
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    return BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state){
          return ListTile(
            leading: Checkbox(
              value: todo.completed,
              onChanged: (bool? checked){
                //bloc 에 이벤트 발생..
                todoBloc.add(ToggleCompletedTodoEvent(todo));
              },
            ),
            title: Text(todo.title),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {
                //event 발생..
                todoBloc.add(DeleteTodoEvent(todo));
              },
            ),
          );
        }
    );
  }
}
