import 'package:flutter/material.dart';
import 'package:yasl/model/list_item.dart';
import 'package:yasl/util/db_client.dart';

class ListItemCard extends StatefulWidget {
  ListItem item;

  _ListItemCardState createState() => _ListItemCardState();

  ListItemCard(this.item);
}

class _ListItemCardState extends State<ListItemCard> {
  var db = new DatabaseHelper();
 
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Container(
        height: 30.0,
        width: 3.0,
        color: Colors.green,
        margin: const EdgeInsets.only(left: 1.0, right: 1.0),
      ),
      title: new Text(widget.item.name),
      trailing: new Checkbox(
        value: widget.item.done,
      ),
      isThreeLine: false,
      // subtitle: Text("1 x"),
      onTap: () {
        _updateItem(widget.item);
        // setState(() {
        //widget.item = true;
        // });
      },
      onLongPress: () {
        _showAddWidget();
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
    );
  }

  void _showAddWidget() {
    var alert = new AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                //      controller: _textEditingController,
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
                //_handleSubmit(_textEditingController.text);
              },
              child: Text("Save"))
        ]);

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _updateItem(ListItem item) async {
    item.done = !item.done;
    int savedId = await db.updateItem(item);
    print("item saved");

    setState(() {
          
        });
  }
}
