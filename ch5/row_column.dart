import 'package:flutter/material.dart';
import 'instagram_widget/header_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: Column(
          children: [
            HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

