import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(new YASL());

class YASL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Yet Another Shopping List",
      theme: new ThemeData(
            primaryColor: Colors.teal[700], 
            accentColor: Colors.teal[100],
          ),
          home: new Home(),
    );
  }
}
