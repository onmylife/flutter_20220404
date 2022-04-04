class User {
  String name = "hello";
}

main() {

  //type 으로 nullable 과 non-null 구분된다...
  int data1 = 10;
  bool? data2;
  double? data3;

  print(data1.isEven);
  print('$data1, $data2, $data3');//10, null, null

  // data1 = null;//error
  data2 = true;
  data2 = null;

  //기본은 항상 non-null 이고.. 개발자가 판단해서 ... 꼭 null 이 되입되어야 하는 것만 선별해서.. nullable 로 선언..
  User user1 = User();//객체생성...
  User? user2 = User();
  user1.name = "world";
  // user1 = null;//error
  user2.name = "world";
  user2 = null;
  user2?.name = "world";//nullable 로 선언하면 member 접근을 null safety 연산자 이용해야..


  //모두다 객체임으로.. 기초 데이터의 자동 형변형 제공하지 않는다..
  data3 = data1.toDouble();
  int data4 = data3.toInt();

  //var vs dynamic....
  var a1 = 10;
  dynamic a2 = 10;

  // a1 = "hello";//error...
  a2 = "hello";//ok

  //var 에 초기값을 안주면...
  var a3;//var 로 선언하면서 초기값을 주어야 타입이 유추되는 것이고.. 초기값을 주지 않으면 dynamic
  a3 = 10;
  a3 = "hello";


  //List...........
  //선언하면서 초기값...
  List list1 = [10, true, "hello"];
  List<int> list2 = [10, 20];
  //배열처럼.. [] 로.. 이용...
  list1[0] = 20;
  list1.add(40);

  //2차원 배열....
  List<List<int>> list3 = [[10, 20], [30, 40]];

  //사이즈만 주고 선언...
  //filled 라는 생성자 이용해서 사이즈 지정...
  List list4 = List.filled(3, null);

}