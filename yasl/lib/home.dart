import 'package:flutter/material.dart';
import 'package:yasl/model/Listitem.dart';
import 'package:yasl/util/db_client.dart';
import './pages/shoppinglist.dart';
import './pages/recepies.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}
enum SelectedMenuOption { premium, settings, categories, help,  }
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
          new Icon(Icons.check_box_outline_blank),
          new Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
          new PopupMenuButton<SelectedMenuOption>(
            onSelected: (SelectedMenuOption result) {
              setState(() {
               // _selection = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SelectedMenuOption>>[
                  const PopupMenuItem<SelectedMenuOption>(
                    value: SelectedMenuOption.premium,
                    child: const Text('Premium'),
                  ),
                  const PopupMenuItem<SelectedMenuOption>(
                    value: SelectedMenuOption.categories,
                    child: const Text('Manage categories'),
                  ),
                  const PopupMenuItem<SelectedMenuOption>(
                    value: SelectedMenuOption.settings,
                    child: const Text('Settings'),
                  ),
                  const PopupMenuItem<SelectedMenuOption>(
                    value: SelectedMenuOption.help,
                    child: const Text('Help'),
                  ),
                ],
          )
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
}
