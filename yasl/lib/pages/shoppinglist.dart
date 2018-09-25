import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';

class Shoppinglist extends StatefulWidget {
  _ShoppinglistState createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
  var db = new DatabaseHelper();
  final List<ListItem> _itemList = <ListItem>[];

  @override
  void initState() {
    super.initState();

    _readItemsToList();
  }

  @override
  Widget build(BuildContext context) {
        _readItemsToList();
    return Scaffold(
      body: new Column(
        children: <Widget> [
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.green,
                  child: new ListTile(
                    title: _itemList[index])
                );
              },
            ),)
        ]
      ),

    );
  }

  _readItemsToList() async {
    List items = await db.getAllItems();
    _itemList.clear();
    items.forEach((item) {
      _itemList.add(ListItem.map(item));
      print("item");
    });
  }
}
