import 'package:flutter/material.dart';
import 'package:yasl/pages/categories.dart';
import 'package:yasl/pages/recepies.dart';
import 'package:yasl/pages/shoppinglist.dart';

class Drawerr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        new ListTile(
          leading: new Icon(Icons.list),
          title: new Text('Shopping List'),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Shoppinglist()));
          },
        ),
        new ListTile(
          leading: new Icon(Icons.kitchen),
          title: new Text('Recepies'),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Recepies()));
          },
        ),
        new ListTile(
          leading: new Icon(Icons.rounded_corner),
          title: new Text('Manage categories'),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Categories()));
          },
        ),
        new ListTile(
          leading: new Icon(Icons.settings),
          title: new Text('Settings'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        new Divider(
          color: Colors.black45,
          indent: 16.0,
        ),
        new ListTile(
          title: new Text('About us'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        new ListTile(
          title: new Text('Privacy'),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    ));
  }
}
