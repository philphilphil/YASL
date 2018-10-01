import 'package:flutter/material.dart';
import 'package:yasl/model/Listitem.dart';
import 'package:yasl/util/Drawer.dart';
import 'package:yasl/util/db_client.dart';
import './pages/shoppinglist.dart';
import './pages/recepies.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

enum SelectedMenuOption {
  premium,
  settings,
  categories,
  help,
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var db = new DatabaseHelper();
  final TextEditingController _textEditingController =
      new TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    ListItem item = new ListItem(text, DateTime.now().toIso8601String());
    int savedId = await db.saveItem(item);
    print("item saved with id $savedId");
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("YASL"),
        //elevation: 0.7,
      ),
      body: Center(child: Text('My Page!')),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: new Icon(Icons.add),
        onPressed: _showAddWidget,
      ),
      drawer: new Drawerr()
    );
  }
}
