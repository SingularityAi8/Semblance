import 'package:flutter/material.dart';
import 'baseapp.dart' as baseapp;
import 'vocalapp.dart' as vocalapp;
import 'chatapp.dart' as chatapp;


String text = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: baseapp.BaseApp(),
        routes: <String, WidgetBuilder>{
          '/ChatApp': (context) => chatapp.ChatApp(),
          '/VocalApp': (context) => vocalapp.VocalApp(),
        },
    );
  }
}


