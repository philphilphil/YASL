import 'package:flutter/material.dart';
import 'package:yasl/util/Drawer.dart';

class Categories extends StatefulWidget {
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Manage Categories"),
      ),
      drawer: new Drawerr(),
      body: new ReorderableListView(
        children: <Widget>[
          ListTile(
            key: new ObjectKey("foo"),
            leading: Icon(Icons.fastfood),
            title: Text('Maultaschen'),
          ),
          ListTile(
            key: new ObjectKey("2"),
            leading: Icon(Icons.photo_album),
            title: Text('Schnipo'),
          ),
          ListTile(
            key: new ObjectKey("fo33o"),
            leading: Icon(Icons.phone),
            title: Text('Geschnezeltes'),
          ),
        ], onReorder: (int oldIndex, int newIndex) {},
      ),
    );
  }
}
