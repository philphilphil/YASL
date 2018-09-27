import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';

class Shoppinglist extends StatefulWidget {
  _ShoppinglistState createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
  var _result;
  var db = new DatabaseHelper();
  var _addItemDisplayed = false;

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
    _addItemDisplayed = false;
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

  @override
  Widget build(BuildContext context) {
    //when result is not there yet, return empty
    if (_result == null) {
      return new Scaffold(
        body: new Container(),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(Icons.add),
          onPressed: null,
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
          itemCount: _result.length + 1, //+1 for eventuall "add item"
          itemBuilder: (_, int index) {
            if (index > _result.length) {
              return new Container();
            }

            // Check if anywhere in the list, an item exacly like this exists, if not, add a dummy card to add this item. this is here so the card is on #1
            if (index == 0) {
              var matchFound = false;
              for (ListItem i in _result) {
                if (i.name.toLowerCase() == _filter.toLowerCase()) {
                  matchFound = true;
                  break;
                }
              }

              if (!matchFound && _filter != "") {
                return new ListTile(
                  leading: new CircleAvatar(backgroundColor: Colors.green),
                  title: new Text("Add $_filter to the list."),
                );
              } else {
                return new Container();
              }
            }

            var actualItemCount = index - 1;
            print(actualItemCount);
            //When filter is empty, just display everything
            if (_filter == null || _filter == "") {
              return new CheckboxListTile(
                secondary: new Container(
                  height: 30.0,
                  width: 3.0,
                  color: Colors.green,
                  margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                ),
                title: new Text(_result[actualItemCount].name),
                value: _result[actualItemCount].done,
                
                onChanged: (bool value) {
                  // setState(() {
                  print("tap");
                  // });
                },
              );

              //When filter not empty, do some things
            } else {
              if (_result[actualItemCount]
                  .name
                  .toLowerCase()
                  .contains(_filter.toLowerCase())) {
                return new CheckboxListTile(
                    title: new Text(_result[actualItemCount].name),
                    value: _result[actualItemCount].done,
                    onChanged: (bool value) {
                      // setState(() {
                      print("tap");
                      // });
                    });
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
