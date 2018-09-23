import 'package:flutter/material.dart';

class Recepies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
