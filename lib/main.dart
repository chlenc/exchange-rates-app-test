import 'package:flutter/material.dart';
import 'package:hello_world/ValutesList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "title",
      home: ValutesList(),
    );
  }
}