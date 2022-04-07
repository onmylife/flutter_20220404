import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IsolateScreen(),
    );
  }
}

class IsolateScreen extends StatefulWidget {
  @override
  IsolateScreenState createState() => IsolateScreenState();
}

class IsolateScreenState extends State<IsolateScreen> {

  //Listview 의 paging 을 적용할 거다...
  //유저는 스크롤만 한다.. 다음 페이지의 데이터가 필요한지를 판단하려면.. 유저 스크롤 정보 획득해야 한다..
  //이벤트..
  ScrollController controller = ScrollController();

  List datas = [];//서버 데이터...
  //서버 요청 데이터...
  int page = 1;//페이지 번호..
  int seed = 1;//refresh 정보..

  //isolate 에 의해 실행될 함수...
  //main thread 에 데이터 전달되게.. sendport 받아서...
  //서버 연동...
  static dataLoader(SendPort sendPort) async {
    //서버 연동하기 위해서는 page 번호..  seed 값 등이 필요하다..
    //이런 데이터는 main 에서 발생하는 데이터이다..  그 값을 받아야 한다.
    ReceivePort port = ReceivePort();
    //main 에게 sendport 전달...  main 이 전달한 sendport 이용해서..
    sendPort.send(port.sendPort);

    await for(var msg in port){
      String url = msg[0];
      SendPort replyTo = msg[1];//결과 전달하기 위한... 네트워크 결과...

      //네트웍 시도...
      http.Response response = await http.get(Uri.parse(url));
      //결과 전달..
      replyTo.send(json.decode(response.body));
    }
  }
  //main thread 가 호출... 네트워킹이 필요한 순간... 최초,  페이징...  refresh
  Future<List> getServerData() async {
    String url = 'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20';
    print(url);

    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;
    ReceivePort response = ReceivePort();
    sendPort.send([url, response.sendPort]);
    Map<String, dynamic> result = await response.first;
    return result['results'];
  }

  @override
  void initState() {
    super.initState();
    //스크롤 이벤트 등록..
    controller.addListener(_scrollListener);
    //초기 데이터 . 서버에서 획득..
    getServerData().then((result){
      //서버데이터 획득.. 화면 re-rendering...
      setState(() {
        datas = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //refresh 상황에서 호출될 개발자 함수..
  Future<List<dynamic>> _refresh() async {
    page = 1;
    seed++;
    List result = await getServerData();
    setState(() {
      datas = result;
    });
    return result;
  }

  //스크롤 이벤트 발생시 호출될 개발자 함수..
  _scrollListener() async {
    //마지막 항목까지 스크롤이 된건지 판단해서.. 그 경우에 서버 연동..
    if(controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange){
      page++;
      List result = await getServerData();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Isolate Example'),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
              //ListView() - 단순 스크롤 개념으로만 사용할때.. 항목 갯수 많은경우 비효율적
            //동일 타입의 항목이 많은 경우. ListView.builder() 생성자.. 화면에 뿌릴 정도만 초기화..
            //ListView.separated() -  ListView.builder() + 항목 구분자까지 제공..
              controller: controller,
              itemBuilder: (BuildContext context, int position){
                //항목 구성은 꾸미기 나름이지만... 전형적인 항목(title, subtitle, leading, trail) 등을
                //표시하기에는 ListTile 이 최고...
                return ListTile(
                  contentPadding: EdgeInsets.all(5),
                  title: Text('${datas[position]['name']['first']} ${datas[position]['name']['last']}'),
                  subtitle: Text(datas[position]['email']),
                  leading: CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.network(datas[position]['picture']['thumbnail']),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int position){
                return Divider(
                  color: Colors.black,
                  height: 2,
                );
              },
              itemCount: datas.length
          ),
        )
    );
  }
}
