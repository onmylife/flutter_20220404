
import 'package:flutter/material.dart';

main(){
  runApp(MyApp());//매개변수에 지정한 개발자 위젯 클래스가 화면에 출력..
}

class MyApp extends StatelessWidget {
  //이 위젯이 화면에 출력될때... 자동 호출..
  //이 함수에서 리턴시키는 위젯이 화면에 출력..
  @override
  Widget build(BuildContext context) {
    //google 의 material design 에 입각한 화면구성의 여러 도움을 주는 위젯...
    //나는 iso 스타일의 테마가 적용된 화면을 구성하고 싶다... 루트 위젯을.. CupertinoApp
    //android, ios 따로 대응하겠다면..Platform api 로 유저 플랫폼을 식별해서.. MaterialApp, CupertinoApp
    return MaterialApp(
      //화면의 기본 틀...(titlebar, body 등... )구조를 잡아주는 Scaffold 를 사용..
      home: Scaffold(
        appBar: AppBar(title: Text("Test"),),
        body: Center(
          child: Column(
            children: [
              MyStatelessWidget(),
              MyStatefulWidget()
            ],
          ),
        )
      )
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  bool favorited = false;
  int count = 10;

  void toggle() {
    print('toggle......');
    if(favorited){
      count -= 1;
      favorited = false;
    }else {
      count += 1;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("stateless build...");
    return Row(
      children: [
        IconButton(
            onPressed: toggle,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border))
        ),
        Text('$count')
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int count = 10;

  void toggle() {
    print('toggle......');
    setState(() {
      if(favorited){
        count -= 1;
        favorited = false;
      }else {
        count += 1;
        favorited = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print("state build...");
    return Row(
      children: [
        IconButton(
            onPressed: toggle,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border))
        ),
        Text('$count')
      ],
    );
  }
}
