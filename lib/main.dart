import 'package:flutter/material.dart';

//////////////////////////////////////////////
//①dictionary.dartのインポート
import './UI/dictionary.dart';
//////////////////////////////////////////////

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Colors.cyan[800],
          primarySwatch: Colors.cyan
      ),

//////////////////////////////////////////////
      //①表示内容にdictionaryを設定
      home: Dictionary(),
//////////////////////////////////////////////

    );
  }
}