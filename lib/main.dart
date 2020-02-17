import 'package:demo/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Solid Software',
      theme: ThemeData(
        backgroundColor: Colors.blue[300],
        buttonColor: Colors.blue[100],
      ),
      home: HomePage(),
    );
  }
}
