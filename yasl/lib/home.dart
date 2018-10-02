import 'package:flutter/material.dart';
import 'package:yasl/model/Listitem.dart';
import 'package:yasl/util/Drawer.dart';
import 'package:yasl/util/db_client.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

enum SelectedMenuOption {
  premium,
  settings,
  categories,
  help,
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("YASL"),
          //elevation: 0.7,
        ),
        body: Center(child: Text('My Page!')),
        drawer: new Drawerr());
  }
}
