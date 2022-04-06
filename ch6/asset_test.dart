import 'package:flutter/material.dart';
import 'dart:convert';//json parsing...
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetTestWidget extends StatelessWidget {

  Widget makeTextAssetWidget(context){
    //리소스 파일 로딩.. 읽는 작업이다.. 시간 오래 걸릴 수 있다.. 비동기 처리되어야 한다...
    //비동기 처리된 데이터를 받아서.. 화면을 구성하는데 효율적인 위젯...
    return FutureBuilder(
        //FutureBuilder 는 비동기 처리에 의해 발생한 데이터로 화면을 구성하겠다는 것이 목적이다.. 데이터는????
        future: DefaultAssetBundle.of(context).loadString("assets/text/my_text.txt"),
        builder: (context, snapshot){//future 쪽에서 발생한 데이터로 화면을 구성하기 위해서.. 데이터 발생 순간.. 함수 자동 호출..
          //두번째 매개변수가.. 데이터..
          if(snapshot.hasData){
            return Text('text file... ${snapshot.data}');
          }
          return Text("");//비동기 처리를 목적으로 한다.. 데이터가 늦게 발생된다는 의미이다... 먼저 찍힐 기본 위젯...
        }
    );
  }

  Widget makeJsonAssetWidget(context){
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/data.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var root = json.decode(snapshot.data.toString());
            return Text('json data ... ${root[0]['name']}, ${root[0]['age']}');
          }
          return Text('');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage('assets/icon/user.png'),
        ),
        Image.asset('assets/icon/user.png'),
        makeTextAssetWidget(context),
        makeJsonAssetWidget(context),
        Icon(Icons.add),
        Icon(Icons.menu),
        Icon(FontAwesomeIcons.music, size: 30, color: Colors.pink,)
      ],
    );
  }
}