import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';
import './pages/shoppinglist.dart';
import './pages/recepies.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      new TextEditingController();
  TabController _tabController;
var db = new DatabaseHelper();


void _handleSubmit(String text) async {
  _textEditingController.clear();
  ListItem item = new ListItem(text, DateTime.now().toIso8601String());
  int savedId = await db.saveItem(item);
  print("Item saved with id: $savedId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("YASL"),
        //elevation: 0.7,
        bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal[700],
            tabs: <Widget>[
              new Tab(
                text: "Shopping list",
              ),
              new Tab(text: "Recepies")
            ]),
        actions: <Widget>[
          new Icon(Icons.search),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
          new Icon(Icons.more_vert)
        ],
      ),
      body: new TabBarView(
          controller: _tabController,
          children: <Widget>[new Shoppinglist(), new Recepies()]),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: new Icon(Icons.add),
        onPressed: _showAddWidget,
      ),
    );
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
                //_textEditingController.clear();
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
}
