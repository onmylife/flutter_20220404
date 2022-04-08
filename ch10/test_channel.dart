import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Channel',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativeCallWidget(),
    );
  }
}

class NativeCallWidget extends StatefulWidget {
  @override
  NativeCallWidgetState createState() => NativeCallWidgetState();
}

class NativeCallWidgetState extends State<NativeCallWidget> {

  //test1..........................
  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCallWithMessageChannel() async {
    const channel = BasicMessageChannel<String>('myMessageChannel', StringCodec());
    // Send message to platform and receive reply.
    String? result = await channel.send('Hello, i am flutter message');
    print('reply, ${result}');
    setState(() {
      resultMessage=result;

    });
    // Receive messages from platform and send replies.
    channel.setMessageHandler((String? message) async {
      print('Received: $message');
      setState(() {
        receiveMessage=message;
      });
      return 'Hi from Dart';
    });

  }

  //test2... method channel...........
  String? resultMethod;

  Future<Null> nativeCallWithMethodChannel() async {
    const methodChannel = const MethodChannel('myMethodChannel');
    try {
      var details = {'Username':'kkang','Password':'1234'};
      //넘기는 데이터는 단순 타입이어도 된다.
      final Map result = await methodChannel.invokeMethod("parameterMap", details);
      print("${result["one"]}, ${result["two"]}");
      setState(() {
        resultMethod="${result["one"]}, ${result["two"]}";
      });
    } on PlatformException catch (e) {// Native에서 result.error() 호출 시
      print("Failed: '${e.message}'.");
    }
  }
  //test2............event channel.......................
  String? resultEvent;
  Future<Null> registerEventChannel() async {
    const channel = EventChannel('eventChannel');
    channel.receiveBroadcastStream().listen((dynamic event) {
      print('Received event: $event');
      setState(() {
        resultEvent='Received event: $event';
      });
    }, onError: (dynamic error) {
      print('Received error: ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Channel Test")),
        body: Center(
          child: Column(
            children: (<Widget>[
              //test1.......................................
              Text('resultMessage : $resultMessage'),
              Text('receiveMessage : $receiveMessage'),
              ElevatedButton(
                  child: Text('native call - message channel'),
                  onPressed: (){
                    nativeCallWithMessageChannel();
                  }
              ),
              //test2..................................
              Text('resultMethod : $resultMethod'),
              ElevatedButton(
                  child: Text('native call - method channel'),
                  onPressed: (){
                    nativeCallWithMethodChannel();
                  }
              ),
              Text('resultEvent : $resultEvent'),
              ElevatedButton(
                  child: Text('register event'),
                  onPressed: (){
                    registerEventChannel();
                  }
              ),
            ]),
          ),
        )
    );
  }
}
