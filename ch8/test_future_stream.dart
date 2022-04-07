import 'package:flutter/material.dart';
import 'FutureWidget.dart';
import 'MyUtil.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Text('one page'),
    Text('two page')
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
                title: Text('Future'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Stream'),
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
