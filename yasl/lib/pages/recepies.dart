import 'package:flutter/material.dart';
import 'package:yasl/util/Drawer.dart';

class Recepies extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Recepies"),
      ),
      drawer: new Drawerr(),
      body: new ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Maultaschen'),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Schnipo'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Geschnezeltes'),
          ),
        ],
      ),
    );
  }
}
