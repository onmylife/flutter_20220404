class User {
  String? name;
  int? age;

  User(this.name, this.age);

  //named constructor...
  User.one(){}
  User.two(String name, int age): this(name, age);
}

class SingletonClass {
  int? data;
  //생성자를 private 으로 지정해서 외부에서 직접 생성하지 못하게..
  //dart 에서는 이름 앞에 _ 가 추가되면 private 개념이다..
  SingletonClass._privateConstructor();
  static final SingletonClass _instance = SingletonClass._privateConstructor();
  factory SingletonClass() => _instance;
}

//interface....
class MyClass {
  int no = 10;
  MyClass(this.no);
  String helloFun(String who) => "Hello $who";
}
class SubClass extends MyClass {
  SubClass(no): super(no);
}
class InterfaceClass implements MyClass {
  @override
  int no = 20;

  @override
  String helloFun(String who) {
    // TODO: implement helloFun
    throw UnimplementedError();
  }
}

//mixin....
class A{}
mixin MyMixin on A{
  int mixInData = 0;
  void mixInFun() {}
}
class MixInClass extends A with MyMixin {

}

main() {
  User user1 = User('hello', 20);
  User user2 = User.one();
  User user3 = User.two('hello', 20);

  SingletonClass obj1 = SingletonClass();
  SingletonClass obj2 = SingletonClass();
  obj1.data = 10;
  obj2.data = 20;
  print('${obj1.data}, ${obj2.data}');//20, 20

  MixInClass obj3 = MixInClass();
  obj3.mixInData = 30;
  obj3.mixInFun();
}