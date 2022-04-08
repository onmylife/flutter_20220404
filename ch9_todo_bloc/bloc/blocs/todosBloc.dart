import 'package:bloc/bloc.dart';
import '../events/events.dart';
import '../states/todosState.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  //버전이 업되면서.. 8.x.. 상위 생성자 호출로 초기화...
  //생성자에서 이벤트 타입 등록..
  TodoBloc(): super(TodoState([])){
    //이벤트 등록... 이벤트에 의한 state 관리...
    on<AddTodoEvent>((event, emit){
      //event 발생에 의해 과거의 데이터를 변경하는 것이 아니라...
      //새로운 데이터를 만드는 것이다..
      List<Todo> newTodos = List.from(state.todos)
          ..add(event.todo);
      //emit 으로 발생시킨 데이터가.. 현 시점 bloc 에 의해 유지되는 상태...
      emit(TodoState(newTodos));
    });

    on<DeleteTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..remove(event.todo);
      emit(TodoState(newTodos));
    });

    on<ToggleCompletedTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodoState(newTodos));
    });
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('$error, $stackTrace');
  }
}