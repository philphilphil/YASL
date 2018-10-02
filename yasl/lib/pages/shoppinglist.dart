import 'package:flutter/material.dart';
import 'package:yasl/model/Listitem.dart';
import 'package:yasl/util/Drawer.dart';
import 'package:yasl/util/ListItemCard.dart';
import 'package:yasl/util/db_client.dart';

class Shoppinglist extends StatefulWidget {
  _ShoppinglistState createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
  var _result;
  var db = new DatabaseHelper();
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

  // reload data from db and set state
  void _reloadList() {
    _readItemsToList().then((result) {
      setState(() {
        _result = result;
        _filter = filterCtrl.text;
      });
    });
  }

  //get data from db
  _readItemsToList() async {
    List items = await db.getAllItems();
    List<ListItem> _itemList = <ListItem>[];
    items.forEach((item) {
      _itemList.add(ListItem.map(item));
    });
    return _itemList;
  }

  //callback function
  refresh() {
    _reloadList();
  }

  void _addNewItem(String filter) async {
    ListItem item = new ListItem(filter, DateTime.now().toIso8601String());
    int savedId = await db.saveItem(item);
    filterCtrl.clear();
    refresh();
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _filterEditComplete() async {
    var text = filterCtrl.text;
    bool matchFound = _itemInList(text);

    if (!matchFound) {
      _addNewItem(text);
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
      filterCtrl.clear();
    }
  }

  bool _itemInList(String text) {
    for (ListItem i in _result) {
      if (i.name.toLowerCase() == text.toLowerCase()) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    //when result is not there yet or no items, return empty
    if (_result == null) {
      return new Scaffold(
        body: new Container(),
        drawer: new Drawerr(),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(Icons.add),
          onPressed: null,
        ),
      );
    }

    //load normal widget
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Shopping List"),
        ),
        drawer: new Drawerr(),
        body: new Column(children: <Widget>[
          new TextField(
            onEditingComplete: () {
              _filterEditComplete();
            },
            controller: filterCtrl,
          ),
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(4.0),
              reverse: false,
              itemCount: _result.length + 1, //+1 for eventuall "add item"
              itemBuilder: (_, int index) {
                //last item will not exist because index is +1
                if (index > _result.length) {
                  return new Container();
                }

                // Check if anywhere in the list, an item exacly like this exists, if not, add a dummy card to add this item. this is here so the card is on #1
                if (index == 0) {
                  var matchFound = _itemInList(_filter);

                  if (!matchFound && _filter != "") {
                    return new ListTile(
                      leading: new CircleAvatar(backgroundColor: Colors.green),
                      title: new Text("Add $_filter."),
                      onTap: () {
                        _addNewItem(_filter);
                      },
                    );
                  } else {
                    return new Container();
                  }
                }

                var actualItemCount = index - 1; //because of the first card.
                var name = _result[actualItemCount].name;

                //When filter is empty, just display everything
                if (_filter == null || _filter == "") {
                  return ListItemCard(_result[actualItemCount], this.refresh);
                } else {
                  //When filter not empty, do some things
                  if (name.toLowerCase().contains(_filter.toLowerCase())) {
                    return ListItemCard(_result[actualItemCount], this.refresh);
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
