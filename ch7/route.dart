import 'package:flutter/material.dart';

//화면 전환시 전달할 데이터.. 추상화..
class SendDataClass {
  final String title;
  final String message;

  SendDataClass(this.title, this.message);
}

main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => FirstScreen(),
      '/second': (context) => SecondScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text('Go Second'),
            onPressed: () {
              _navgate(context);
            }),
      ),
    );
  }

  _navgate(BuildContext context) async{
    //화면전환.. named route... 데이터 전달...
    final result = await Navigator.pushNamed(
        context,
        '/second',
        arguments: {"arg1":'hello', "model": SendDataClass('mytitle', 'helloworld')}
    );
    print('result : $result');
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //전달된 데이터 획득...
    Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: Text('${args['arg1']}, ${(args['model'] as SendDataClass).title}'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go Back'),
          onPressed: () {
            Navigator.pop(context, "world");
          },
        ),
      ),
    );
  }
}