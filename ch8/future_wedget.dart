import 'package:flutter/material.dart';
import 'my_util.dart';

class FutureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(//Future 데이터만 지정해 주면 알아서.. 호출.. 대기.. 전달시.. builder 실행..
        future: getServerData('1'),
        builder: (context, snapshot){//두번째 매개변수가 데이터... 화면 구성해서 리턴...
          if(snapshot.hasData){
            return getWidget(snapshot.data ?? []);
          }else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          //초기에도 호출된다.. 초기 화면... 빙빙빙...
          return CircularProgressIndicator();
        }
    );
  }
}