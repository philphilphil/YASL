import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  String name;
  String category;
  bool done;

  ListItemCard(this.name, this.done, this.category);

  @override
  Widget build(BuildContext context) {
    return new CheckboxListTile(
      secondary: new Container(
        height: 30.0,
        width: 3.0,
        color: Colors.green,
        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
      ),
      title: new Text(name),
      value: done,
       isThreeLine: false,
       subtitle: Text("1 x"),
      onChanged: (bool value) {
        // setState(() {
        print("tap");
        // });
      },
    );
  }
}