import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//popup menu..
const List<String> _choice = [
  '신고',
  '게시물 알림 설정',
  '링크 복사'
];

class HeaderWidget extends StatelessWidget {
  void _select(String choice){
    //popupu menu event....
    //toast 띄우기...
    Fluttertoast.showToast(
        msg: choice,
        toastLength: Toast.LENGTH_SHORT,//LENGTH_LONG
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //이미지를... 리소스 이미지...
        Image.asset('images/lab_instagram_icon_0.jpg'),
        Container(//특정 위젯이 화면에 출력되는 사각형 정보를 다양하게 설정하기 위한 위젯...
          padding: EdgeInsets.only(left: 16),
          child: Text('instagram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        Spacer(),//여백만 차지하는 위젯...
        //쩜쩜쩜...  overflowmenu 출력...
        PopupMenuButton<String>(
            itemBuilder: (BuildContext context){
              //이 함수에서 리턴 시키는 위젯이... overflow menu 항목...
              return _choice.map((String choice){
                return PopupMenuItem(
                    child: Text(choice),
                    value: choice,
                );
              }).toList();
            },
            onSelected: _select,
        )
      ],
    );
  }
}