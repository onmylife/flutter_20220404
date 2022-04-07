import 'package:flutter/material.dart';
import 'package:flutter_lab/ch8/future_wedget.dart';
import 'package:flutter_lab/ch8/stream_widget.dart';
import 'my_util.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    FutureWidget(),
    StreamWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getServerData('1');
    return MaterialApp(
      home: (Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Text('Future Stream Test'),
              ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Future'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Stream'
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          )),
    );
  }
}
