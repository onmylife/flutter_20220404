import 'package:flutter/material.dart';
import 'package:flutter_lab/ch5/instagram_widget/content_widget.dart';
import 'instagram_widget/header_widget.dart';
import 'instagram_widget/image_widget.dart';
import 'instagram_widget/icon_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        //화면이 벗어나서 위젯이 나열 되는 경우.. 스크롤을 지원해야 한다...
        //SingleChildScrllView + Column : 다양한 타입, 사이즈의 위젯을 나열.. 스크롤..
        //ListView : 동일 타입의 위젯.. 스크롤..
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              ImageWidget(),
              IconWidget(),
              ContentWidget()
            ],
          ),
        )
      ),
    );
  }
}

