import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget> {
  //상위에서 유지하는 데이터.. 이 데이터가 하위에 전파되어 하위에서도 이용된다는 가정..
  int _counter = 0;

  void _incrementCount() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LifeCycle Test'),
        ),
        //상위의 데이터를 하위에 전파하기 위한 목적...
        body: Provider.value(
            value: _counter,//하위에 전파되는 데이터..
            updateShouldNotify: (oldValue, newValue) => true,//상위 데이터 변경시 이 함수 호출하고..
          //이 함수가 true 를 리턴한 경우만 하위에 전파..
          //물론 디폴트 함수가 true 리턴..
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ParentWidget... $_counter'),
                ChildWidget()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCount,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget constructor...');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildWidgetState();
  }
}
//WidgetsBindingObserver - app lifecycle 감지를 위해서... (화면에 나오는 순간.. 사라지는 순간등)
class ChildWidgetState extends State<ChildWidget> with WidgetsBindingObserver {
  int _counter = 0;//하위의 데이터..

  ChildWidgetState() {
    print('ChildWidgetState constructor....');
  }
  @override
  void initState() {
    print('initState....');
    super.initState();
    //위젯을 위한 초기화 로직..
    //이벤트 등록... 앱 상태 이벤트 등록..
    WidgetsBinding.instance!.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeDependencies() {
    //상위 위젯에서 전달하는 데이터 획득...
    _counter = Provider.of<int>(context);
    print('didChangeDependencies..... $_counter');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('ChildWidgetState.... build...');
    return Text('ChildWidget $_counter');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('didChangeAppLifecycleState... $state');
    switch(state){
      case AppLifecycleState.resumed:
        print('resume....');
        break;
      case AppLifecycleState.paused:
        print('pause....');
        break;
    }
  }
}








