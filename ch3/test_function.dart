//typedef - 타입 재정의..
//함수 타입 선언하면서 꼭 제네릭을 이용해야 하는 것은 아니다..
typedef MyFunctionType<T, A> = T Function(A arg);

main() {
  //optional 로 선언된 매개변수는 호출하는 곳에서 대입을 안시킬 수 있다는 의미...
  //모든것이 객체이다.. null 이 대입되어야 한다.. nullable 로 선언하던가..
  //non-null 로 선언하려면.. default 값 명시해야 한다..
  void namedOptional(bool data, {String? data1, int data2 = 0}){

  }
  namedOptional(true, data1: "hello", data2: 100);
  namedOptional(true, data2: 100, data1: "hello");

  void unnamedOptional(bool data, [String data1 = "hello", int? data2]){

  }
  unnamedOptional(true);
  unnamedOptional(true, "world", 100);

  //...........................................
  int some(int no){
    return no * 10;
  }
  //Hof(High Order Function - 고차함수 - 매개변수로, 리턴값으로 함수를 사용하는 함수..)
  Function testFun(int Function(int a) argFun){
    argFun(10);
    return some;
  }
  var result = testFun((int arg) => arg * 10);
  result(10);

  int testFun2(MyFunctionType<int, int> argFun){
    return argFun(10);
  }
}
















