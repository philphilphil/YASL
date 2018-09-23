import 'package:flutter/material.dart';

class Shoppinglist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Milch'),
          ),
          ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Schokolade'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text('Pizza'),
          ),
        ],
      ),
    );
  }
}
