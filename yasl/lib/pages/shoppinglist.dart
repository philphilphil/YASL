import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';

class Shoppinglist extends StatefulWidget {
  _ShoppinglistState createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
  var _result;
  var db = new DatabaseHelper();
  final List<ListItem> _itemList = <ListItem>[];
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    //big help: https://flutter.institute/run-async-operation-on-widget-creation/
    super.initState();
    _readItemsToList().then((result) {
      setState(() {
        _result = result;
      });
    });
  }

  _readItemsToList() async {
    List items = await db.getAllItems();
    _itemList.clear();
    items.forEach((item) {
      _itemList.add(ListItem.map(item));
    });

    return _itemList;
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    ListItem item = new ListItem(text, DateTime.now().toIso8601String());
    int savedId = await db.saveItem(item);
    //print("Item saved with id: $savedId");
    _itemList.add(item);
  }

  void _showAddWidget() {
    var alert = new AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "Item",
                    hintText: "Name of the item",
                    icon: new Icon(Icons.note_add)),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                _handleSubmit(_textEditingController.text);
                _textEditingController.clear();
              },
              child: Text("Save")),
          new FlatButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel"))
        ]);

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_result == null) {
      // This is what we show while we're loading
      return new Container();
    }

    return Scaffold(
      body: new Column(children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(4.0),
            reverse: false,
            itemCount: _result.length,
            itemBuilder: (_, int index) {
              return Card(
                  color: Colors.green,
                  child: new ListTile(title: _result[index]));
            },
          ),
        )
      ]),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: new Icon(Icons.add),
        onPressed: _showAddWidget,
      ),
    );
  }
}
