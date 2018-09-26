import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';

class Shoppinglist extends StatefulWidget {
  _ShoppinglistState createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
  var _result;
  var db = new DatabaseHelper();
  final TextEditingController _textEditingController =
      new TextEditingController();
  TextEditingController filterCtrl = new TextEditingController();
  String _filter;

  @override
  void initState() {
    //big help: https://flutter.institute/run-async-operation-on-widget-creation/
    super.initState();

    filterCtrl.addListener(() {
      _reloadList();
    });

    _reloadList();
  }

  void _reloadList() {
    _readItemsToList().then((result) {
      setState(() {
        _result = result;
        _filter = filterCtrl.text;
      });
    });
  }

  _readItemsToList() async {
    List items = await db.getAllItems();
    List<ListItem> _itemList = <ListItem>[];
    items.forEach((item) {
      _itemList.add(ListItem.map(item));
    });
    return _itemList;
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    ListItem item = new ListItem(text, DateTime.now().toIso8601String());
    int savedId = await db.saveItem(item);
    _reloadList();
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
    //when result is not there yet, return empty
    if (_result == null) {
      return new Scaffold(
        body: new Container(),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(Icons.add),
          onPressed: _showAddWidget,
        ),
      );
    }

    //load normal widget
    return Container(
        child: new Column(children: <Widget>[
      new TextField(
        controller: filterCtrl,
      ),
      new Flexible(
        child: new ListView.builder(
          padding: new EdgeInsets.all(4.0),
          reverse: false,
          itemCount: _result.length,
          itemBuilder: (_, int index) {
            if (_filter == null || _filter == "") {
              print(_result[index].name);
              print(_result[index].done);
              // return Card(
              //     color: Theme.of(context).accentColor,
              //     child: new ListTile(title: _result[index]));
              return new CheckboxListTile(
                title: new Text(_result[index].name),
                value: true,
                onChanged: (bool value) {
                  // setState(() {
                   print("tap");
                  // });
                },
              );
            } else {
              if (_result[index].name.toLowerCase().contains(_filter)) {
                return new Card(
                    color: Theme.of(context).accentColor,
                    child: new ListTile(title: _result[index]));
              } else {
                return new Container();
              }
            }
          },
        ),
      )
    ]));
  }
}
