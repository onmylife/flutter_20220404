

//앱 전역에서 관리되어야 하는 상태 데이터..
//Bloc 에 의해 관리...
//특별 작성규칙은 없다..
class Todo {
  String title;
  bool completed;
  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

class TodoState {
  List<Todo> todos;
  TodoState(this.todos);
}