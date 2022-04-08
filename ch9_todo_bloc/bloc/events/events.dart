import '../states/todosState.dart';

//app 전역에서 .. state 데이터 변경(생성, 삭제, 수정)흐름.. 이벤트..
//enum 상수로.. - 이벤트 발생시.. bloc 에 넘길 데이터가 없다면..
//class - 넘길 데이터 있는 경우..

abstract class TodoEvent {}
class AddTodoEvent extends TodoEvent {
  Todo todo;
  AddTodoEvent(this.todo);
}
class DeleteTodoEvent extends TodoEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
class ToggleCompletedTodoEvent extends TodoEvent {
  Todo todo;
  ToggleCompletedTodoEvent(this.todo);
}