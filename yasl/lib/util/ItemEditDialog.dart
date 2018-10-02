import 'package:flutter/material.dart';
import 'package:yasl/model/ListItem.dart';
import 'package:yasl/util/db_client.dart';

class ItemEditDialog extends StatefulWidget {
  var nameCtrl = new TextEditingController();
  ListItem item;
  int id;
  Function callback;
  ItemEditDialog(this.id, this.callback);

  _ItemEditDialogState createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  var nameCtrl = new TextEditingController();
  var db = new DatabaseHelper();

  _deleteItem() async {
    db.deleteItem(widget.id);
    widget.callback();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = "asd";
    return new SimpleDialog(
      title: const Text("Edit"),
      contentPadding: EdgeInsets.all(15.0),
      children: <Widget>[
        new TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: 'Item Name'),
        ),
        new TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: 'Description'),
        ),
        new Row(
          children: <Widget>[
            new CircleAvatar(backgroundColor: Colors.green),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
            new Text("Amount: 1"),
            new IconButton(
              icon: new Icon(Icons.add),
              tooltip: 'Increase',
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.remove),
              tooltip: 'Decrease',
              onPressed: () {},
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new FlatButton(
                onPressed: () {
                  //_handleSubmit(_textEditingController.text);
                },
                child: Text("Save")),
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            new FlatButton(
                onPressed: () {
                  _deleteItem();
                },
                child: Text("Delete"))
          ],
        )
      ],
    );
  }
}
