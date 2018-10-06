import 'package:flutter/material.dart';
import 'package:yasl/util/Drawer.dart';

class Categories extends StatefulWidget {
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var _switch = true;

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Manage Categories"),
        ),
        drawer: new Drawerr(),
        body: new ReorderableListView(
          // header: Card(
          //   child: Text("Drag to reorder. Tap to rename."),
          // ),
          children: <Widget>[
            SwitchListTile(
              key: Key("1"),
              title: const Text('Fruits and Vegetables'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.green,
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("2"),
              title: const Text('Meat and Sausage'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.pink[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("3"),
              title: const Text('Snacks and Sweets'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.red[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("4"),
              title: const Text('Bakery'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.brown[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("5"),
              title: const Text('Drinks'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.yellow[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("6"),
              title: const Text('Frozen'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.blue[300],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("7"),
              title: const Text('Refrigerated'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.blue[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("8"),
              title: const Text('General Groceries'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.orange[300],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("9"),
              title: const Text('Empty 1'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.lime[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            ),
            SwitchListTile(
              key: Key("10"),
              title: const Text('Empty 2'),
              value: _switch,
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              secondary: new Container(
                height: 30.0,
                width: 30.0,
                color: Colors.grey[200],
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
              ),
            )
          ],
          onReorder: (int oldIndex, int newIndex) {},
        ));
  }
}
