import 'package:flutter/material.dart';
import 'dart:async';
import 'my_util.dart';

class StreamWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StreamWidgetState();
  }
}

class StreamWidgetState extends State<StreamWidget>{
  List<Article> list = [];
  //데이터가... Future 타입... 여러번 호출... Future 타입의 데이터를 아래의  controller 에 추가...
  //controller 를 StreamBuilder 에 걸어서...
  StreamController<List<Article>> controller = StreamController();

  void getData(int page) async {
    await getServerData(page.toString())
        .then((data){
          //getServerData() 에서 리턴하는 것은 future 이다... stream 으로.. controller 에 추가해서..
        controller.add(data);
    });
  }

  int transform(int i){
    int page = ++i;
    getData(page);
    return i;
  }

  _peridoicStream() async {
    //5초마다.. 반복적으로.. 5번만...
    Duration interval = Duration(seconds: 5);
    Stream<int> stream = Stream<int>.periodic(interval, transform);
    stream = stream.take(5);
    await for(int i in stream){//stream 을 조합한후.. 어디선가.. 이용해야. stream 이 움직여서...
      print('...$i');
    }
  }

  @override
  void initState() {
    super.initState();
    _peridoicStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            list.addAll(snapshot.data);
            return getWidget(list);
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        }
    );
  }
}